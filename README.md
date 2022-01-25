# switch-cmake

Extensible CMake toolchain for Nintendo Switch homebrew development with devkitA64 and libnx.

## Table of Contents

- [Introduction](#introduction)
  * [Why CMake](#why-cmake)
  * [Quick Start](#quick-start)
- [Switch Homebrew](#switch-homebrew)
  * [File Formats](#file-formats)
  * [devkitPro Ecosystem](#devkitpro-ecosystem)
    + [devkitA64](#devkita64)
    + [portlibs](#portlibs)
    + [tools](#tools)
  * [libnx](#libnx)
- [CMake Files](#cmake-files)
  * [FindLibnx.cmake](#findlibnxcmake)
  * [FindLibTwili.cmake](#findlibtwilicmake)
  * [FindMbedTLS.cmake](#findmbedtlscmake)
  * [SwitchTools.cmake](#switchtoolscmake)
- [Templates](#templates)
  * [Application](#application)
  * [Library](#library)
  * [System Module](#system-module)

## Introduction

This project aims to provide a CMake toolchain for Nintendo Switch homebrew development using devkitA64 and libnx. It is
intended as an alternative to the makefile-based system currently provided with the tools. 

### Why CMake

[TODO]

### Quick Start

#### Prerequisites

First, make sure you have installed the latest release of devkitA64, the Nintendo Switch homebrew development kit 
provided by devkitPro. Follow the installation guide [here](https://devkitpro.org/wiki/Getting_Started). 

**Important**: Make sure that the devkitPro environment variables have been configured properly. CMake will use these to 
locate the devkitA64 tools. Specifically, the `${DEVKITPRO}` variable should point to the devkitPro installation 
directory. 

You'll also need to have [CMake](https://cmake.org/download).

___

#### Building the examples

To build the template examples, clone this repository and open a terminal in the root directory. Make a build directory 
with:

```shell
$ mkdir build
```

Next, have CMake configure the project and generate build files with:

```shell
$ cmake -G "Unix Makefiles" --toolchain=DevkitA64Libnx.cmake -S . -B build
```

The `-G "Unix Makefiles"` argument specifies which 
[generator](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html) CMake will use. In this case, CMake will
output Makefiles when the project is built.

The `--toolchain=DevkitA64Libnx.cmake` argument specifies which 
[toolchain file](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html) CMake will use. This will configure
CMake to use the DevkitPro environment and compilers.

Finally, build the project with

```shell
$ cmake --build build
```

You should now have a `my_app.nro` executable in the `./build/templates/application/` directory. 

___

#### Running the examples

Running your homebrew on your Nintendo Switch is easy when netloading with `nxlink`, which is packaged with devkitA64.

**Important:** Your Switch needs to be running the [Atmosphère](https://github.com/Atmosphere-NX/Atmosphere) custom 
firmware with `hbmenu` installed. Please also make sure the Switch is connected to the same wireless network as your 
computer.

On your Nintendo Switch, open the Gallery applet to start `hbmenu`, then press Y to start the netloader.

In the repository's root directory, run the following command to upload and run the executable:

```shell
$ nxlink ./build/templates/application/my_app.nro
```

If `nxlink` fails with the message `No response from Switch!`, try supplying the Switch's IP address via the `-a <IP>` 
argument.

When the executable finishes uploading, you should see a `Hello World!` message in the top left of your Switch's 
display.

## Switch Homebrew

### File Formats

### devkitPro Ecosystem

#### devkitA64

#### portlibs

### libnx

## CMake Files

### FindLibnx.cmake

### FindLibTwili.cmake

### FindMbedTLS.cmake

### SwitchTools.cmake

## Templates

### Application

### Library

### System Module
