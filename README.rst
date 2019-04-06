.. _libnx: https://github.com/switchbrew/libnx
.. _yuzu: https://github.com/yuzu-emu/yuzu
.. _discord: https://discord.gg/jA8npnf

=======================
libnx homebrew template
=======================

So, you want to develop homebrew for the Nintendo Switch? This can be quite a mess, especially when you're new to it.
But don't worry, we've got you. The probably most commonly used library is libnx_. But when you look around on GitHub,
you just find repositories with a bunch of C/C++ source files and a Makefile for building the app. However, this
template focuses on providing a full CMake setup for a homebrew project.

Why CMake
#########

At this point, you're probably wondering yourself why the hell you should use CMake instead of a simple Makefile.

First of all, it is important to know the difference:

**Makefile:** A buildsystem that drives the compiler and other build tools and tells them how to build your project.

**CMake:** A generator of buildsystems. It can produce Makefiles, Ninja build files, XCode and Visual Studio projects,
and many more. And all that from the same entry point.

Now here are some aspects why I personally recommend CMake instead of Makefiles.

Readability
...........

Basically all Switch homebrew applications use Makefiles derived from
`this repository <https://github.com/switchbrew/switch-examples>`_.

These Makefiles just look horribly gross and are very unreadable. Even though I'm familiar
with reading Makefiles, I haven't understood many lines of them when I first read them (and
there are certain parts I honestly don't even understand today).

This CMake setup is much more concise, doesn't hide important details (you won't even know
where your compiler is located from reading the Makefile) and is much cleaner.

And on top of that, it will be a lot easier for you to understand what's going on, even if
you're unfamiliar with both, CMake and Makefiles.

CMake will be used to generate Makefiles for this project, but the good news is that you don't
have to read or understand them. A nice thing are for example so-called `out-of-source builds
<https://gitlab.kitware.com/cmake/community/wikis/FAQ#what-is-an-out-of-source-build>`_.

Extensibility
.............

It's a fact that it is easier to extend CMake than extending Makefiles.

Learning
........

You will definitely learn more by reading this approach to building Switch homebrew
than by reading these Makefiles of doom.

All of them contain the line ``include $(DEVKITPRO)/libnx/switch_rules`` which basically
includes all the internal logic of building Switch homebrew to the Makefile, invisible for
users. This basically just means more effort than necessary if you want to understand the
process.

Development
...........

This one's an important aspect from my point of view. CMake gives more people the ability
to contribute to your project. But why?

We've discussed before that CMake is a generator of buildsystems. If you're using Visual
Studio, just generate a Visual Studio project and start editing. If you're using XCode,
generate an XCode project then. CLion is also an IDE many people use. And without CMake,
it doesn't provide any autocomplete at all.

And here's the point. By using CMake, you give more people the ability to use the full
potential of their editor and potentially more people will be able to contribute to your
project. And thanks to CMake supporting toolchain files, you can even build your project
for multiple platforms very easily.

How to use
##########

Just clone this repository, delete the ``.git`` directory and you can get started.

Then, edit your ``CMakeLists.txt`` file::

    # Replace this with the name of your project.
    set(HOMEBREW_APP "my_cool_app")

    # Meta information about the app
    set(APP_TITLE ${HOMEBREW_APP})
    set(APP_AUTHOR "SwitchPy")
    # set(APP_ICON "assets/icon.png")

    set(VERSION_MAJOR 0)
    set(VERSION_MINOR 0)
    set(VERSION_MICRO 1)
    set(APP_VERSION
            "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_MICRO}")

After providing all relevant information for your homebrew app, you can try to build it.

Open a Command Prompt window/PowerShell/Terminal in the directory of the project and use the following commands:

.. code-block:: shell

    # First of all, you might want to create directory to not mix up CMake helpers and project files.
    mkdir build && cd build

    # Assuming you're in the build directory, generate CMake helpers.
    cmake .. -DCMAKE_TOOLCHAIN_FILE=../devkita64-libnx.cmake

    # Now we will generate all the binaries. These are for now just nso and nro files.
    make

After these steps, you should see a ``${target}.nro`` file with a bunch of other (unnecessary) files in your project
directory. At this point, you're done if you haven't got any errors.

Now get yourself the yuzu_ Nintendo Switch emulator and open the nro file you've just built. The result should be
the output ``Hello World!`` on your screen.

Now you're all set. Edit ``src/main.cc``, add more files, extend your CMake setup and build a fantastic homebrew app.

**Note: We include a C++ example file. It however works with C source files too.**

Troubleshooting
###############

Why does CLion refuse to load up my CMakeLists.txt?
...................................................

Navigate to ``Settings > Build, Execution, Deployment > CMake`` and add your toolchain file to ``CMake options``.

.. image:: https://user-images.githubusercontent.com/38182450/55671407-0261a780-5890-11e9-88ef-3f658db272fd.png
    :align: left

Any errors which aren't stated here? Feel free to open an issue or join our Discord_ server to discuss the issue more
directly.
