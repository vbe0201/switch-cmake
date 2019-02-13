.. _libnx: https://github.com/switchbrew/libnx
.. _yuzu: https://github.com/yuzu-emu/yuzu
.. _discord: https://discord.gg/jA8npnf

==============
libnx template
==============

So, you want to develop homebrew for the Nintendo Switch? This can be quite a mess, especially when you're new to it.
But don't worry, we've got you. The probably most commonly used library is libnx_. But when you look around on GitHub,
you just find repositories with a bunch of C/C++ source files and a Makefile for building the app. However, this
template focuses on providing a full CMake setup for a homebrew project.

Why CMake
#########

At this point, you're probably wondering yourself why the hell you should use CMake instead of a simple Makefile.

First of all, it is important to know the difference:

**Makefile:** A buildsystem that drives the compiler and other build tools and tells them how to build your project.

**Cmake:** A generator of buildsystems. It can produce Makefiles, Ninja build files, XCode projects, and many more.
And all that from the same entry point.

And that is exactly the reason why CMake is so powerful. It makes it really easy for other people to collaborate on your
project and makes your project more future-proof. It brings a lot of features that allow you to easily manage dependencies,
interface with libraries or integrate with other tools.

This is why buildsystem generators in general (CMake in this case) are our personal recommendation for C/C++ projects.

How to use
##########

Just get yourself a copy of this project and you're ready to start.

Then, edit your ``CMakeLists.txt`` file::

    # Replace this with the name of your project.
    set(HOMEBREW_APP "My cool app")
    # The file name of your executable (without file ending)
    set(target "app")

    # Homebrew app meta information.
    set(HOMEBREW_TITLE "Nice Homebrew App")
    set(HOMEBREW_AUTHOR "SwitchPy")
    set(HOMEBREW_ICON "path/to/my/icon.png")

After providing all relevant information for your homebrew app, you can try to build it.

Open a command prompt window/powershell/terminal in the directory of the project and use the following commands:

.. code-block:: shell

    # First of all, use this command to generate your Makefile and compile your program.
    cmake .

    # Now we will generate a ``${target}.nro`` file which is your executable.
    make

After these steps, you should see a ``${target}.nro`` file with a bunch of other (unnecessary) files in your project
directory. At this point, you're done if you haven't got any errors.

Now get yourself the yuzu_ Nintendo Switch emulator and open the nro file you've just built. The result should be
the output ``Hello World!`` on your screen.

Now you're all set. Edit ``src/main.c``, add more files, extend your CMake setup and build a fantastic homebrew app.

**Note: We include a C example file. However, this CMake configuration also is able to build C++17 source code.**

Troubleshooting
###############

Any errors? Feel free to open an issue or join our Discord_ server to discuss the issue more directly.
