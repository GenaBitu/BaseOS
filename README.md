# BaseOS
Basic Operating system written in C/C++ and assembly. Created for learning purposes.

Usage
-----
You need a linux environment with bash and apt in order to build BaseOS as it is. You also need at least 300MB of disk space and a basic understanding of bash.

1. chmod +x all the shell scripts, so that you can execute them later
2. Run initialize.sh - it will download all neccessary tools (it will ask for a sudo password in order to do that) and download and compile a GCC cross-compiler. This can take a lot of time. Run this only once adter cloning repo.
3. Run make - this will actualy produce the object files from the source code.
4. Run make-iso.sh - this will make an iso, that can be burned to a DVD/USB stick or used by an emulator (see 5.)
5. Run run-iso.sh - this will run QEMU (virtual machine) and boot your fresh iso.
