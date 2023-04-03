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
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("service-account-file.json")
app = firebase_admin.initialize_app(cred)
firestore_client = firestore.client()

relay = MediaRelay()

# Load the TFLite model and allocate tensors
interpreter = tf.lite.Interpreter(model_path='Finalmodel2.tflite')
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

class VideoTransformTrack(MediaStreamTrack):

    kind = "video"
    channel = None

    correct_frames = 0
    incorrect_frames = 0
    fire_count =0

    def __init__(self, track):
        super().__init__()
        self.track = track

    async def recv(self):
        print("received")
        
        video_frame = await self.track.recv()
        frame = video_frame.to_rgb().to_ndarray()

        # Preprocess the frame
        img = cv2.resize(frame, (256, 256))
        img = img / 255.0
        img = np.expand_dims(img, axis=0)

        # Set the input tensor
        img = tf.image.convert_image_dtype(img, tf.float32)
        interpreter.set_tensor(input_details[0]['index'], img)

        # Run inference
        interpreter.invoke()

        # Get the output tensor
        output_data = interpreter.get_tensor(output_details[0]['index'])

        # Determine if the frame contains fire or not
        if output_data[0][0] > 0.5:
            fire = False
        else:
            fire = True
            self.fire_count+=1

        print(fire)

        # Update frame rate and accuracy information every 10 frames
        if self.fire_count>=10:
            print('New Fire Detected!')

            try:
                # doc_ref = firestore_client.collection("Fire Case")
                # doc_ref.add(
                #     {
                #     "name": "HP EliteBook Model 1",
                #     "brand": "HP",
                #     }
                # )
                self.fire_count=0
            except Exception as e:
                print(e)

        return video_frame

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