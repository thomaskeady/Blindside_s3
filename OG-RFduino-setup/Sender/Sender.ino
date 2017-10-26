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

// Make this a empty payload since not doing raw signal analysis anymore?
//char payload[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
char payload[] = {};

int led = 3;

void setup() {
  SimbleeCOM.begin();
  pinMode(led, OUTPUT);
}

void loop() {
  SimbleeCOM.send(payload, sizeof(payload));
  digitalWrite(led, HIGH);
  delay(50);
  SimbleeCOM.send(payload, sizeof(payload));
  digitalWrite(led, LOW);
  delay(50);
}
  
