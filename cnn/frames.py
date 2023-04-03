#!/usr/bin/env python
# coding: utf-8

# In[1]:


get_ipython().run_line_magic('pip', 'install opencv-python')
get_ipython().run_line_magic('pip', 'install tensorflow')


# In[1]:


import tensorflow as tf
import cv2
import numpy as np
import time

# Load the TFLite model and allocate tensors
interpreter = tf.lite.Interpreter(model_path='C:/FireProtector/FireProtector/cnn/Finalmodel2.tflite')
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Open the default webcam
cap = cv2.VideoCapture(0)

# Initialize variables for tracking accuracy and frame rate
correct_frames = 0
incorrect_frames = 0
labels = []  # list to store the labels of each frame in the video
start_time = time.time()

# Loop through all the frames in the video
while True:
    # Read a frame from the webcam
    ret, frame = cap.read()

    # Check if the frame was successfully read
    if ret:
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
          
            labels.append(1)
            if labels[-1] == 1:
                correct_frames += 1
            else:
                incorrect_frames += 1
        else:
            fire = True
            labels.append(0)
            if labels[-1] == 0:
                correct_frames += 1
            else:
                incorrect_frames += 1

        print(fire)

        # Display the frame and label
        cv2.putText(frame, f'Fire: {fire}', (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (255,255, 255), 2)
        cv2.imshow('Frame', frame)

        # Wait for a key press
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        # Update frame rate and accuracy information every 10 frames
        if len(labels) % 10 == 0:
            elapsed_time = time.time() - start_time
            fps = 10 / elapsed_time
            accuracy = correct_frames / (correct_frames + incorrect_frames)
            print(f'Frame rate: {fps:.2f} fps')
            print(f'Accuracy: {accuracy:.2f}')
            start_time = time.time()
            correct_frames = 0
            incorrect_frames = 0

    else:
        break

# Release the webcam and close all windows
cap.release()
cv2.destroyAllWindows()

