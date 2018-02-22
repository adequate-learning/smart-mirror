#!/usr/bin/env python 

print("please w8")

import face_recognition
import picamera
import numpy as np
from RPLCD.i2c import CharLCD


import RPi.GPIO as GPIO
import time
import os
import json
import requests

GPIO.setmode(GPIO.BCM)

import sys
import Adafruit_DHT

TRIG = 23
ECHO = 24
SENSOR_PIN = 12

GPIO.setup(TRIG, GPIO.OUT)
GPIO.setup(ECHO, GPIO.IN)
GPIO.setup(SENSOR_PIN, GPIO.IN)

camera = picamera.PiCamera()
#camera = picamera.PiCamera()
camera.rotation = 180
camera.resolution = (320, 240)
output = np.empty((240, 320, 3), dtype=np.uint8)
# Load a sample picture and learn how to recognize it.
print("Loading known face images")
pia_image = face_recognition.load_image_file("pia_test.jpg")
pia_face_encoding = face_recognition.face_encodings(pia_image)[0]


lcd = CharLCD("PCF8574", 0x3f)

def display_humidity():
    print("Fetch Temperature and Humidity data")

    humidity, temperature = Adafruit_DHT.read_retry(11, 4)

    lcd.cursor_pos = (0, 0)
    lcd.write_string("Temp: %d C" % temperature)
    lcd.cursor_pos = (1, 0)
    lcd.write_string("Humidity: %d %%" % humidity)
    
    print("Temperature: %d C" % temperature)
    print("Humidity: %d %%" % humidity)
    return (humidity, temperature)


def distance_measurement():
    print("Distance Measurement In Progress")

    GPIO.output(TRIG, False)
    print("Waiting For Sensor To Settle")
    time.sleep(2)

    GPIO.output(TRIG, True)
    time.sleep(0.00001)
    GPIO.output(TRIG, False)

    while GPIO.input(ECHO)==0:
        pulse_start = time.time()

    while GPIO.input(ECHO)==1:
        pulse_end = time.time()

    pulse_duration = pulse_end - pulse_start

    distance = pulse_duration * 17150

    distance = round(distance, 2)

    print("Distance:",distance,"cm")
    return distance
 
def toggleLED(channel, onoff):
    GPIO.output(channel, onoff)

def ident_user():
    print("takes picture to identify user")
    name = None

    # Initialize some variables
    face_locations = []
    face_encodings = []

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

        if match[0]:
            name = "Pia"
            print("I see {}!".format(name))
        else:
            name = "Unknown"
            print("I see an unknown person!")

    return name

def post_data(distance, temperature, humidity, name):
    data = {
        'tile': {
            'name': name,
            'temperature': int(temperature),
            'humidity': int(humidity),
            'distance': int(distance)
        }
    }
    url = 'http://localhost:4000/api/tiles' 
    response = requests.post(url, json=data)
    print(response.status_code)
    print(response.text)
    print(response.json())
    return response
  
  

def callback(channel):
    print("motion detected")
    distance = distance_measurement()
    if distance <= 120:
        name = ident_user()
        humidity, temperature = display_humidity()

        post_data(distance, temperature, humidity, name)
    else:
        print("user needs to come closer")
        

try:
    GPIO.add_event_detect(SENSOR_PIN , GPIO.RISING, callback=callback)
    while True:
        time.sleep(0.2)

except KeyboardInterrupt:
    print("Done...")

finally:
    GPIO.cleanup()
