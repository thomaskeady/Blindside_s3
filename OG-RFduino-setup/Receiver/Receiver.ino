
/*
 * Copyright (c) 2015 RF Digital Corp. All Rights Reserved.
 *
 * The source code contained in this file and all intellectual property embodied in
 * or covering the source code is the property of RF Digital Corp. or its licensors.
 * Your right to use this source code and intellectual property is non-transferable,
 * non-sub licensable, revocable, and subject to terms and conditions of the
 * SIMBLEE SOFTWARE LICENSE AGREEMENT.
 * http://www.simblee.com/licenses/SimbleeSoftwareLicenseAgreement.txt
 *
 * THE SOURCE CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
 *
 * This heading must NOT be removed from this file.
 */

#include "SimbleeCOM.h"
//#include <QueueList.h>
#include <QList.h>
#include "QList.cpp"

const int SAMPLES_TO_AVG = 10;

int led = 3;
bool led_state = false;

bool serialing = false;
int grssi = 0;
int receivedCount = 0;
bool gotNew = false;

void setup() {
  //Serial.begin(9600);
  Serial.begin(19200);

  pinMode(led, OUTPUT);

  SimbleeCOM.begin();

  //Serial.println("Started");
  //noInterrupts();
}

//QueueList<int> queue;
QList<int> queue;

void loop() {

  if (Serial.available() > 0) {
    serialing = true;
    //Serial.println(grssi/receivedCount);
    //Serial.println(receivedCount);
    //Serial.println(grssi/queue.count()); // Any reason to clear queue after? for all new data?
    Serial.println(grssi/queue.size()); // Any reason to clear queue after? for all new data?
    // queue.count() should always = 10 but if interrupt occurs between these two ifs
    // then it would be 11, lets not risk
    
    while (Serial.available() != 0) {
      Serial.read();
    }
    serialing = false;

    //grssi = 0;
  }

  if (gotNew) { // Separate ifs for startup when queue is empty
    if (queue.size() == SAMPLES_TO_AVG + 1) {
      //grssi -= queue.pop(); // Subtract the oldest value
      grssi -= queue.back(); // Subtract the oldest value
      queue.pop_back(); // Remove the oldest value
    }
    gotNew = false;
  }
  
}

void SimbleeCOM_onReceive(unsigned int esn, const char *payload, int len, int rssi)
{
  if (!serialing) {
    grssi += rssi;
    //grssi = rssi;
    //receivedCount++;
    //queue.push(rssi);
    queue.push_front(rssi);
    gotNew = true;
    
  } else {
    led_state = !led_state;
    if (led_state) {
      digitalWrite(led, HIGH);
    } else {
      digitalWrite(led, LOW);
    }
  }
}
