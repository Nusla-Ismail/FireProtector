import cv2

# Open the input video file
in_file = "video.mp4"
cap = cv2.VideoCapture(in_file)

# Set up the output video file
out_file = "output2.mp4"
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
fps = int(cap.get(cv2.CAP_PROP_FPS))
frame_size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)), int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))
out = cv2.VideoWriter(out_file, fourcc, fps, frame_size, True)

while True:
    # Read the next frame from the input video
    ret, frame = cap.read()

    # If there are no more frames, break out of the loop
    if not ret:
        break

    # Convert the BGR frame to RGB
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # Write the RGB frame to the output video
    out.write(frame_rgb)

# Release the input and output video files
cap.release()
out.release()