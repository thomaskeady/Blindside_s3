from time import sleep
import serial
ser = serial.Serial('/dev/tty.usbserial-DN00B9FJ', 19200) # Establish the connection on a specific port
counter = 32 # Below 32 everything in ASCII is gibberish
while True:
     counter +=1
     #ser.write(str(chr(counter))) # Convert the decimal number to ASCII then send it to the Arduino
     ser.write('A');
     print ("Before readline");
     print ser.readline() # Read the newest output from the Arduino
     print ("After readline");
     sleep(.1) # Delay for one tenth of a second
     if counter == 255:
         counter = 32
