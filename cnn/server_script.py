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
import pytz
import datetime
import onesignal
from onesignal.api import default_api
from onesignal.model.notification import Notification
from onesignal.model.create_notification_success_response import CreateNotificationSuccessResponse
from onesignal.model.bad_request_error import BadRequestError

cred = credentials.Certificate("service-account-file.json")
app = initialize_app(cred, {'storageBucket': 'fireprotector-c6a91.appspot.com'})
db = firestore.client()

# See configuration.py for a list of all supported configuration parameters.
# Some of the OneSignal endpoints require USER_KEY bearer token for authorization as long as others require APP_KEY
# (also knows as REST_API_KEY). We recommend adding both of them in the configuration page so that you will not need
# to figure it yourself.
configuration = onesignal.Configuration(
    app_key = "ee2c0dd2-30d5-4f30-8851-5a56ba833bc8",
    user_key = "ODVhNTJkYTItM2M3NC00ODY1LTliMTYtNWY0OGNjODNkNjJi"
)


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

                    users_doc_ref = db.collection('users').document(str(uid))
                    users_doc = users_doc_ref.get()


                    try:
                        if users_doc.exists:
                            isReported = users_doc.to_dict()["isFire"]
                            if isReported == False:
                                await self.upload_to_storage()
                                await self.create_fire_case()
                                await self.fire_notification()
                        else:
                            await self.upload_to_storage()
                            await self.create_fire_case()
                            await self.fire_notification()
                    except Exception as e:
                        print("Error:",e)

        

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
        global video_url
        video_url = blob.public_url
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
                print('No such document!')

            current_case_id = last_case_id+1

            print("Current Case:",current_case_id)

            users_doc_ref = db.collection('users').document(str(uid))
            users_doc = users_doc_ref.get()

            if users_doc.exists:
                global location
                global notification_id
                location = users_doc.to_dict()["location"]
                notification_id = users_doc.to_dict()["notification"]
                print()
                print("Location:",location)
                print("Player ID:",notification_id)
            else:
                print("Location:",location)


            # set timezone to Sri Lanka
            timezone = pytz.timezone('Asia/Colombo')

            # get current date and time
            current_datetime = datetime.datetime.now(timezone)

            # get current date separately
            current_date = str(current_datetime.date())

            # get current time separately
            current_time = str(current_datetime.time().strftime("%H:%M"))

            # print current date and time separately
            print("Current Date:", current_date)
            print("Current Time:", current_time)

            fire_cases_doc = db.collection("fire_cases").document(str(current_case_id))
            fire_cases_doc.set(
                {
                "case_id": current_case_id,
                "user_id" : uid,
                "location" : location,
                "date" : current_date,
                "time" : current_time,
                "video_url" : video_url,
                "isFire" : True,
                }
            )

            last_case_doc_ref.update({u'id': current_case_id})

            users_doc_ref.update({u'isFire': True})
            
        except Exception as e:
            print("Error: ",e)

    async def fire_notification(self):
        # Enter a context with an instance of the API client
        with onesignal.ApiClient(configuration) as api_client:
            # Create an instance of the API class

            print("Last Player ID:",notification_id)

            api_instance = default_api.DefaultApi(api_client)
            notification = Notification(
                contents={"en": "Fire Alert: A fire has been detected in your location"},
                include_player_ids=[notification_id],
                app_id="ee2c0dd2-30d5-4f30-8851-5a56ba833bc8",
                )

            # example passing only required values which don't have defaults set
            try:
                # Create notification
                api_response = api_instance.create_notification(notification)
                print(api_response)
            except onesignal.ApiException as e:
                print("Exception when calling DefaultApi->create_notification: %s\n" % e)
    

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