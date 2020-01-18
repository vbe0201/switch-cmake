## A CMake helper to find libtwili on the system.
##
## On success, it will define:
## > LIBTWILI_FOUND        - The system has libtwili
## > LIBTWILI_INCLUDE_DIRS - The libtwili include directories
## > LIBTWILI_LIBRARIES    - The static libtwili libraries
##
## It also adds an imported target named `switch::libtwili`.
##
## ```
## target_link_libraries(my_executable switch::libtwili)
## ```
## is equivalent to
## ```
## target_include_directories(my_executable PRIVATE ${LIBTWILI_INCLUDE_DIRS})
## target_link_libraries(my_executable ${LIBTWILI_LIBRARIES})
## ```

include(FindPackageHandleStandardArgs)

if(NOT SWITCH)
    message(FATAL_ERROR "This helper can only be used when cross-compiling for the Switch.")
endif()

set(LIBTWILI_PATHS ${LIBTWILI} $ENV{LIBTWILI} libtwili ${PORTLIBS}/libtwili)

find_path(LIBTWILI_INCLUDE_DIR twili.h
        PATHS ${LIBTWILI_PATHS}
        PATH_SUFFIXES include)

find_library(LIBTWILI_LIBRARY NAMES libtwili.a
        PATHS ${LIBTWILI_PATHS}
        PATH_SUFFIXES lib)

set(LIBTWILI_INCLUDE_DIRS ${LIBTWILI_INCLUDE_DIR})
set(LIBTWILI_LIBRARIES ${LIBTWILI_LIBRARY})

find_package_handle_standard_args(LIBTWILI DEFAULT_MSG
        LIBTWILI_INCLUDE_DIR LIBTWILI_LIBRARY)

mark_as_advanced(LIBTWILI_INCLUDE_DIR LIBTWILI_LIBRARY)

if(LIBTWILI_FOUND)
    set(LIBTWILI ${LIBTWILI_INCLUDE_DIR}/..)

    add_library(switch::libtwili STATIC IMPORTED GLOBAL)
    set_target_properties(switch::libtwili PROPERTIES
            IMPORTED_LOCATION "${LIBTWILI_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBTWILI_INCLUDE_DIR}")
endif()
