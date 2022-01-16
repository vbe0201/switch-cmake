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
