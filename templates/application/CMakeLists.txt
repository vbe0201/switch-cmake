cmake_minimum_required(VERSION 3.1)

## Declare project

project(application)

# We set the C standard to 11.
set(CMAKE_C_STANDARD 11)

## CMake modules

# We have to add the cmake directory to have access to
# the Switch tools and also find_package for libnx.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

## Required libraries and utilities

# SwitchTools provide various helper functions for building Switch file formats.
include(SwitchTools)

# Find libnx, which is required by our application.
find_package(Libnx REQUIRED)

## Targets

# First, we want to add the regular ELF target.
add_executable(my_app source/main.c)

# Next, we need to set the required target properties
# so CMake can detect the metadata for the application.
set_target_properties(my_app PROPERTIES
        APP_TITLE "Template Application"
        APP_AUTHOR "Valentin B."
        APP_VERSION "0.1.0")

# Then, we link the required libraries (libnx) against the executable.
target_link_libraries(my_app switch::libnx)

# Set these variables if you don't want to use an icon or
# don't want `add_nro_target` to generate a .nacp file.
#set(NO_ICON TRUE)
#set(NO_NACP TRUE)

# And finally we can add the actual binary (.nro) target.
add_nro_target(my_app)
