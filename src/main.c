// Copyright 2019 SwitchPy Team. All rights reserved.
// Licensed under the MIT license.
// Refer to the LICENSE file included.

#include <stdio.h>

#include <switch.h>

int main() {
    consoleInit(NULL);

    printf("Hello World!\n");

    // main loop
    while (appletMainLoop()) {
        hidScanInput();

        u64 key_down = hidKeysDown(CONTROLLER_P1_AUTO);
        if (key_down & KEY_PLUS) break; // break in order to return to hbmenu

        consoleUpdate(NULL);
    }

    consoleExit(NULL);
    return 0;
}