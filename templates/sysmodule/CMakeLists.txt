## Targets

# First, we want to add the regular ELF target.
add_executable(my_sysmodule source/main.c)

# Next, we need to set the required target properties
# so CMake can detect the JSON configuration for the module.
set_target_properties(my_sysmodule PROPERTIES
    CONFIG_JSON "${CMAKE_CURRENT_LIST_DIR}/sysmodule.json")

# Then, we link the required libraries (libnx) against the executable.
target_link_libraries(my_sysmodule switch::libnx)

# And finally we can add the actual sysmodule (.nsp) target.
add_nsp_target(my_sysmodule)
