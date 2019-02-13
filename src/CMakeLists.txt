set(homebrew_SOURCE_DIR "${PROJECT_SOURCE_DIR}/src")

file(GLOB kscript_SOURCE_FILES RELATIVE "${homebrew_SOURCE_DIR}"
        "*.c"
        "*.cc"
        "*.cpp"
        "*.h"
        "*.hpp")

if (cmake_VERBOSE)
    list(LENGTH homebrew_SOURCE_FILES homebrew_SOURCE_FILES_LENGTH)

    kscript_info("Loaded ${source_files_length} file(s).")
endif ()

add_executable("${target}.elf"
        src/main.c)
