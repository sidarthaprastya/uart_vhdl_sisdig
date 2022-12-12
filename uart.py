import serial
import time
import numpy as np
# import matplotlib.pyplot as plt


ser = serial.Serial('COM7', 9600, bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        timeout=None)

feedback = []


if ser.is_open:
    while (True):
        try:
            data = input("Enter Data: ")
            for word in data:
                ser.write(word.encode("utf-8"))
                feed_char = ser.read().decode("utf-8")
                feedback.append(feed_char)
            
            output = ""
            for element in feedback:
                output += element
            print("Output: " + output)
            feedback.clear()
            # size = ser.inWaiting()
            

        except Exception as e:
            print(e)
            break
    