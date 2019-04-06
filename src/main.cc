// Copyright 2019 SwitchPy Team. All rights reserved.
// Licensed under the MIT license.
// Refer to the LICENSE file included.

#include <iostream>

#include <switch.h>

int main(int argc, char **argv) {
  consoleInit(nullptr);

  std::cout << "Hello World!\n";

  // main loop
  while (appletMainLoop()) {
    hidScanInput();

    u64 key_down = hidKeysDown(CONTROLLER_P1_AUTO);
    if (key_down & KEY_PLUS) break;  // break in order to return to hbmenu

    consoleUpdate(nullptr);
  }

  consoleExit(nullptr);
  return 0;
}