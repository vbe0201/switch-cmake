## A CMake helper to find libnx on the system.
##
## On success, it will define:
## > LIBNX_FOUND        - The system has libnx
## > LIBNX_INCLUDE_DIRS - The libnx include directories
## > LIBNX_LIBRARIES    - The static libnx libraries
##
## It also adds an imported target named `switch::libnx`.
##
## ```
## target_link_libraries(my_executable switch::libnx)
## ```
## is equivalent to
## ```
## target_include_directories(my_executable PRIVATE ${LIBNX_INCLUDE_DIRS})
## target_link_libraries(my_executable ${LIBNX_LIBRARIES})
## ```
##
## By default, CMake will look for libnx in $DEVKITPRO/libnx.
## If you want to use a custom fork, you need to override the
## `LIBNX` variable within CMake before this file is used.

include(FindPackageHandleStandardArgs)

if(NOT SWITCH)
    message(FATAL_ERROR "This helper can only be used when cross-compiling for the Switch.")
endif()

set(LIBNX_PATHS ${LIBNX} $ENV{LIBNX} ${DEVKITPRO}/libnx libnx)

find_path(LIBNX_INCLUDE_DIR switch.h
        PATHS ${LIBNX_PATHS}
        PATH_SUFFIXES include)

find_library(LIBNX_LIBRARY NAMES libnx.a
        PATHS ${LIBNX_PATHS}
        PATH_SUFFIXES lib)

set(LIBNX_INCLUDE_DIRS ${LIBNX_INCLUDE_DIR})
set(LIBNX_LIBRARIES ${LIBNX_LIBRARY})

find_package_handle_standard_args(LIBNX DEFAULT_MSG
        LIBNX_INCLUDE_DIR LIBNX_LIBRARY)

mark_as_advanced(LIBNX_INCLUDE_DIR LIBNX_LIBRARY)

if(LIBNX_FOUND)
    set(LIBNX ${LIBNX_INCLUDE_DIR}/..)

    add_library(switch::libnx STATIC IMPORTED GLOBAL)
    set_target_properties(switch::libnx PROPERTIES
            IMPORTED_LOCATION "${LIBNX_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBNX_INCLUDE_DIR}")
endif()
