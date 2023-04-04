import cv2
import json
from aiohttp import web
import aiohttp_cors
from aiortc import MediaStreamTrack, RTCPeerConnection, RTCSessionDescription
from aiortc.contrib.media import MediaRelay
import tensorflow as tf
import numpy as np
import time
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials, initialize_app, storage

cred = credentials.Certificate("service-account-file.json")
app = initialize_app(cred, {'storageBucket': 'fireprotector-c6a91.appspot.com'})
db = firestore.client()

relay = MediaRelay()

# Load the TFLite model and allocate tensors
interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

class VideoTransformTrack(MediaStreamTrack):

    kind = "video"
    channel = None

    # Initialize the frame counter and FPS calculation.
    frame_count = 0
    start_time = time.time()

    # Set up the video recording parameters.
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = None
    recording = False
    recording_start_time = 0

    def __init__(self, track):
        super().__init__()
        self.track = track

    async def recv(self):
        print("received")
        
        video_frame = await self.track.recv()
        frame = video_frame.to_rgb().to_ndarray()

        # Preprocess the input image.
        resized = cv2.resize(frame, (256, 256), interpolation = cv2.INTER_AREA)
        normalized = resized.astype('float32') / 255.0
        input_data = np.expand_dims(normalized, axis=0)
        
        # Perform the inference.
        try:
            interpreter.set_tensor(input_details[0]['index'], input_data)
            interpreter.invoke()
            output_data = interpreter.get_tensor(output_details[0]['index'])
        except Exception as e:
            print("Error:",e)
        
        # Get the predicted class and confidence.
        prediction = output_data[0][0]
        if prediction < 0.5:
            print("Fire")
            if self.frame_count == 0:
                self.recording = True
                self.recording_start_time = time.time()
        else:
            print("Not Fire")
            if self.recording:
                self.recording = False
                if self.out is not None:
                    self.out.release()
                    self.out = None
                    await self.upload_to_storage()
                    try:
                        await self.create_fire_case()
                    except Exception as e:
                        print("Error: ",e)

        

        self.frame_count += 1

        if self.frame_count % 10 == 0:
            end_time = time.time()
            global fps
            fps = int(self.frame_count / (end_time - self.start_time))
            print('FPS:', fps)
            accuracy = round(prediction * 100, 2)
            print('Accuracy:', accuracy, '%')
            self.frame_count = 0
            self.start_time = end_time
        
        # Save the frames if fire is detected.
        try:
            global frame_rgb
            if self.recording:
                if self.out is None:
                    print("Called 0")
                    self.out =  cv2.VideoWriter('video.mp4', self.fourcc, fps, (frame.shape[1], frame.shape[0]))
                print("Called 1")
                frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                self.out.write(frame_rgb)
                print("Called 2")
                print("recording_start_time",self.recording_start_time)
                elapsed_time = time.time() - self.recording_start_time
                print("Elapsed Time:",elapsed_time)
                print("Called 3")
                if elapsed_time > 10 or self.out.get(cv2.CAP_PROP_POS_FRAMES) * self.out.get(cv2.CAP_PROP_FPS) * 0.000001 > 2:
                    self.recording = False
                    self.out.release()
                    self.out = None
                    print("Called 4")
                    await self.upload_to_storage()
                    await self.create_fire_case()
        except Exception as e:
            print("Error:",e)

        return video_frame
    
    async def upload_to_storage(self):
        bucket = storage.bucket()
        blob = bucket.blob('video.mp4')
        blob.upload_from_filename('video.mp4')
        blob.make_public()
        print("Uploaded to Firebase Storage:", blob.public_url)

    async def create_fire_case(self):
        try:
            last_case_doc_ref = db.collection('currect_case_id').document('currect_case_id')
            last_case_doc = last_case_doc_ref.get()

            if last_case_doc.exists:
                global last_case_id
                last_case_id = last_case_doc.to_dict()["id"]
                print('Last Case ID:',last_case_id)
            else:
                print(u'No such document!')

            current_case_id = last_case_id+1

            print("Current Case:",current_case_id)

            fire_cases_doc = db.collection("fire_cases").document(str(current_case_id))
            fire_cases_doc.set(
                {
                "case_id": current_case_id,
                "user_id" : uid
                }
            )

            last_case_doc_ref.update({u'id': current_case_id})
            




        except Exception as e:
            print("Error: ",e)
    

async def feed_server(request):
    params = await request.json()
    feed_server = RTCSessionDescription(sdp=params["sdp"], type=params["type"])

    pc = RTCPeerConnection()

    @pc.on("datachannel")
    def on_datachannel(channel):
        print("Data channel is created!")

        @channel.on("message")
        async def on_message(message):
            print("Received message:", message)
            global uid
            uid = message

    @pc.on("connectionstatechange")
    async def on_connectionstatechange():
        print("Connection state is",pc.connectionState)
        if pc.connectionState == "failed":
            await pc.close()
        elif pc.connectionState == "connected":
            pc.createDataChannel("data")

    @pc.on("track")
    def on_track(track):
        print("Track",track.kind,"received")
        if track.kind == "video":
            pc.addTrack(VideoTransformTrack(relay.subscribe(track)))

        @track.on("ended")
        async def on_ended():
            print("Track",track.kind,"ended")

    await pc.setRemoteDescription(feed_server)

    answer = await pc.createAnswer()
    await pc.setLocalDescription(answer)

    return web.Response(
        content_type="application/json",
        text=json.dumps(
            {"sdp": pc.localDescription.sdp, "type": pc.localDescription.type}
        ),
    )

def root(request):
    return web.Response(
        content_type="application/json",
        text=json.dumps(
            {"connection": "success"}
        ),
    )

app = web.Application()
cors = aiohttp_cors.setup(app)

app.router.add_post("/model", feed_server)

for route in list(app.router.routes()):
    cors.add(route, {
        "*": aiohttp_cors.ResourceOptions(
            allow_credentials=True,
            expose_headers="*",
            allow_headers="*",
            allow_methods="*"
        )
    })

web.run_app(app, host='0.0.0.0', port='7788')