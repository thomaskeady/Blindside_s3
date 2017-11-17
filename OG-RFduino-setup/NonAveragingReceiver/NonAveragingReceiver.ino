
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

//const int SAMPLES_TO_AVG = 10;

int led = 3;
bool led_state = false;

bool serialing = false;
volatile int grssi_1 = 0;
volatile int grssi_2 = 0;
volatile int grssi_3 = 0;
int receivedCount = 0;
//bool gotNew = false;

//found in Simblee literature, could try and see if it helps?
//SimbleeCOM.mode = LONG_RANGE;

void setup() {
  Serial.begin(9600);
  //Serial.begin(19200);

  pinMode(led, OUTPUT);

  SimbleeCOM.begin();

  //Serial.println("Started");
  //noInterrupts();
}


void loop() {

  if (Serial.available() > 0) {
    serialing = true;
    //delay(500);
    //Serial.println(grssi/receivedCount);
    //Serial.println(receivedCount);
    //Serial.println(grssi/queue.count()); // Any reason to clear queue after? for all new data?
    Serial.printf("1 %d 2 %d 3 %d\n", grssi_1, grssi_2, grssi_3); // Any reason to clear queue after? for all new data?
    //Serial.printf("1 %d", grssi_1);
    // queue.count() should always = 10 but if interrupt occurs between these two ifs
    // then it would be 11, lets not risk

    while (Serial.available() != 0) {
      Serial.read();
    }
    serialing = false;

    //grssi = 0;
  }

}

void SimbleeCOM_onReceive(unsigned int esn, const char *payload, int len, int rssi)
{
   //printf("%d\n", esn);
  if (!serialing) {
    if (esn == -682860272){ //0xc40791c5
       grssi_1 = rssi;
      // printf("1 ");
    }else if (esn == 618982283){ //0xd74c6110
      grssi_2 = rssi;
      //printf("2 ");
    }else if (esn == -1006136891){ //0x24e4eb8b
      grssi_3 = rssi;
      //printf("3");
    }else {
      rssi = 0;
      //printf("none");
    }
    //grssi += rssi;
    //grssi = rssi;
    //receivedCount++;
    //queue.push(rssi);
    //gotNew = true;

  } else {
    led_state = !led_state;
    if (led_state) {
      digitalWrite(led, HIGH);
    } else {
      digitalWrite(led, LOW);
    }
  }
}
