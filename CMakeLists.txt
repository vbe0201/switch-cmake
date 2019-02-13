# Copyright 2019 SwitchPy Team. All rights reserved.
# Licensed under the MIT license.
# Refer to the LICENSE file included.
#
# libnx CMake template for Nintendo Switch homebrew development.

# Replace this with the name of your project.
set(HOMEBREW_APP "My cool app")
# The file name of your executable (without file ending)
set(target "app")

# Homebrew app meta information.
set(HOMEBREW_TITLE "Nice Homebrew App")
set(HOMEBREW_AUTHOR "SwitchPy")
set(HOMEBREW_ICON "path/to/my/icon.png")

cmake_minimum_required(VERSION 3.9)
project(${HOMEBREW_APP})

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(WITH_PORTLIBS ON CACHE BOOL "use portlibs ?")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(utils)
include(options)

# Check for the DEVKITPRO environment variable.
if (NOT DEFINED ENV{DEVKITPRO})
    cmake_panic("Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro")
endif ()

set(DEVKITPRO "$ENV{DEVKITPRO}")
set(LIBNX "${DEVKITPRO}/libnx")
set(PORTLIBS_PATH "${DEVKITPRO}/portlibs")
set(PORTLIBS "${PORTLIBS_PATH}/switch")

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "" FORCE)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE INTERNAL "" FORCE)
set(TESTS_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH}/tests CACHE INTERNAL "" FORCE)

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT "Release")
endif ()

# Replace project with your actual project name.
set(${HOMEBREW_APP}_VERSION_MAJOR 0)
set(${HOMEBREW_APP}_VERSION_MINOR 0)
set(${HOMEBREW_APP}_VERSION_MICRO 1)
set(${HOMEBREW_APP}_VERSION_FULL "${project_VERSION_MAJOR}.${project_VERSION_MINOR}.${project_VERSION_MICRO}")

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(clang-dev-tools)
endif ()

include(nx-utils)

if(WIN32)
    set(CMAKE_C_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc.exe")
    set(CMAKE_CXX_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-g++.exe")
    set(CMAKE_AR "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ar.exe" CACHE STRING "")
    set(CMAKE_RANLIB "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ranlib.exe" CACHE STRING "")
else()
    set(CMAKE_C_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc")
    set(CMAKE_CXX_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-g++")
    set(CMAKE_AR "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ar" CACHE STRING "")
    set(CMAKE_RANLIB "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ranlib" CACHE STRING "")
endif()

set(ARCH "-march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE")
set(NX_C_COMPILE_FLAGS "-g -Wall -O2 -ffunction-sections -D__SWITCH__ ${ARCH}")
set(NX_CXX_COMPILE_FLAGS "${NX_C_COMPILE_FLAGS} -std=c++17 -fno-rtti -fno-exceptions")
set(NX_LINK_FLAGS "-specs=${LIBNX}/switch.specs -g ${ARCH} -Wl,-Map,${TARGET}.map")

# Prevent CMake from assuming we're compiling for macOS and adding platform specific flags
# that strip symbols from resulting elf files.
if (APPLE)
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
endif ()

set(CMAKE_C_COMPILE_FLAGS "${CMAKE_C_COMPILE_FLAGS} ${NX_C_COMPILE_FLAGS}")
set(CMAKE_CXX_COMPILE_FLAGS  "${CMAKE_CXX_COMPILE_FLAGS} ${NX_CXX_COMPILE_FLAGS}")
set(CMAKE_C_LINK_FLAGS  "${CMAKE_C_LINK_FLAGS} ${NX_LINK_FLAGS}")
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} ${NX_LINK_FLAGS}")

if(WITH_PORTLIBS)
    set(CMAKE_FIND_ROOT_PATH ${DEVKITPRO}/devkitA64 ${DEVKITPRO} ${DEVKITPRO}/libnx ${DEVKITPRO}/portlibs/switch)
else()
    set(CMAKE_FIND_ROOT_PATH ${DEVKITPRO}/devkitA64 ${DEVKITPRO}/libnx ${DEVKITPRO})
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

include_directories("${PROJECT_BINARY_DIR}")
include_directories("${PORTLIBS}/include")
include_directories("${LIBNX}/include")

link_directories("${LIBNX}/lib")
link_directories("${PORTLIBS}/lib")

set(CMAKE_STATIC_LINKER_FLAGS_INIT
        "-march=armv8-a -mtune=cortex-a57 -mtp=soft -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")
set(CMAKE_EXE_LINKER_FLAGS_INIT
        "-specs=${DEVKITPRO}/libnx/switch.specs -march=armv8-a -mtune=cortex-a57
        -mtp=soft -fPIE -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "Shared libs not available")
set(CMAKE_INSTALL_PREFIX ${DEVKITPRO}/portlibs/switch)

include(src/CMakeLists.txt)

if (cmake_VERBOSE)
    cmake_info("Building ${HOMEBREW_APP} version ${${HOMEBREW_APP}_VERSION_FULL}")
endif ()

target_link_libraries("${target}.elf" nx)

set_target_properties("${target}.elf" PROPERTIES LINKER_LANGUAGE C)

# Builds the actual .nro executable.
__add_nro_target("${target}.elf" ${HOMEBREW_TITLE} ${HOMEBREW_AUTHOR} ${${HOMEBREW_APP}_VERSION_FULL} ${HOMEBREW_ICON})
