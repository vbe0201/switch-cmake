cmake_minimum_required(VERSION 3.1)

## Declare project

project(sysmodule)

# We set the C standard to 11.
set(CMAKE_C_STANDARD 11)

## Targets

# First, we want to add the regular library target with our source files.
# Libraries cannot be shared, as this is unsupported due to newlib issues.
add_library(my_lib source/templatelib.c)

# Add the include/ directory of the library to the target.
# It is exposed publicly, so other targets that link against `my_lib`
# can use it within code.
target_include_directories(my_lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    )

## Install targets

# Provide the possibility to install the library to portlibs.
install(TARGETS my_lib)
