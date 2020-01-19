cmake_minimum_required(VERSION 3.1)

## Declare project

project(sysmodule)

# We set the C standard to 11.
set(CMAKE_C_STANDARD 11)

## CMake modules

# We have to add the cmake directory to have access to
# the Switch tools and also find_package for libnx.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

## Required libraries and utilities

# SwitchTools provide various helper functions for building Switch file formats.
include(SwitchTools)

# Find libnx, which is required by our sysmodule.
find_package(Libnx REQUIRED)

## Targets

# First, we want to add the regular ELF target.
add_executable(my_sysmodule source/main.c)

# Next, we need to set the required target properties
# so CMake can detect the JSON configuration for the module.
set_target_properties(my_sysmodule PROPERTIES
    CONFIG_JSON "${CMAKE_SOURCE_DIR}/sysmodule.json")

# Then, we link the required libraries (libnx) against the executable.
target_link_libraries(my_sysmodule switch::libnx)

# And finally we can add the actual sysmodule (.nsp) target.
add_nsp_target(my_sysmodule)
