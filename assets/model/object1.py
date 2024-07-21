import cv2
import torch
import numpy as np

# Initialize IP webcam
ip_webcam_url = "http://192.168.152.95:8080/video"  # Changed to HTTP and added /video
cap = cv2.VideoCapture(ip_webcam_url)

# Check if webcam is opened correctly
if not cap.isOpened():
    raise Exception("Could not open video device. Please check the URL and network.")

# Set properties. These numbers can be changed if needed.
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

# Load the YOLOv5 model
model = torch.hub.load('ultralytics/yolov5', 'yolov5s', pretrained=True)

def process_frame(frame):
    # Convert the frame to RGB (YOLOv5 expects RGB images)
    img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    
    # Perform inference
    results = model(img_rgb)
    
    # Render the results on the frame
    results.render()
    
    # Convert back to BGR for OpenCV
    img_bgr = cv2.cvtColor(results.ims[0], cv2.COLOR_RGB2BGR)
    
    return img_bgr

while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    
    if not ret:
        print("Failed to grab frame. Please check the video stream.")
        break
    
    # Process the frame for object detection
    frame = process_frame(frame)
    
    # Display the resulting frame
    cv2.imshow('YOLOv5 Object Detection', frame)
    
    # Break the loop on 'q' key press
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
cap.release()
cv2.destroyAllWindows()
