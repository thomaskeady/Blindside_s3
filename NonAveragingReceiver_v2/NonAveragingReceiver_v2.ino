#include "SimbleeCOM.h"

void setup() {
  Serial.begin(19200); // set the baud rate
  SimbleeCOM.begin();
  Serial.println("Ready"); // print "Ready" once
}

volatile bool serialing = false;
volatile int grssi = 0;

void loop() {
  char inByte = ' ';
  if (Serial.available()) { // only send data back if data has been sent
    serialing = true;
    
    //char inByte = Serial.read(); // read the incoming data
    Serial.println(grssi); // send the data back in a new line so that it is not all one long line

    while (Serial.available() != 0) {
      Serial.read();
    }

    serialing = false;
  }
  //delay(100); // delay for 1/10 of a second
}

void SimbleeCOM_onReceive(unsigned int esn, const char *payload, int len, int rssi) {
  
  if (!serialing) {
    grssi = rssi;

  } 
  
}

