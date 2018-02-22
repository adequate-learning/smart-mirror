print("please w8")

import face_recognition
import picamera
import numpy as np
import time

camera = picamera.PiCamera()
camera.rotation = 180
camera.resolution = (320, 240)
output = np.empty((240, 320, 3), dtype=np.uint8)

# Load a sample picture and learn how to recognize it.
print("Loading known face images")
pia_image = face_recognition.load_image_file("pia_test.jpg")
pia_face_encoding = face_recognition.face_encodings(pia_image)[0]

# Initialize some variables
face_locations = []
face_encodings = []

while True:
    print("Capturing image.")
    # Grab a single frame of video from the RPi camera as a numpy array
    camera.start_preview()
    camera.capture(output, format="rgb")

    # Find all the faces and face encodings in the current frame of video
    face_locations = face_recognition.face_locations(output)
    print("Found {} faces in camera.".format(len(face_locations)))
    face_encodings = face_recognition.face_encodings(output, face_locations)

    # Loop over each face found in the frame to see if it's someone we know.
    for face_encoding in face_encodings:
        # See if the face is a match for the known face(s)
        match = face_recognition.compare_faces([pia_face_encoding], face_encoding)
        name = "<Unknown Person>"

        if match[0]:
            name = "Pia"

        print("I see someone named {}!".format(name))

    time.sleep(2)
