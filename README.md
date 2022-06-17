# toolchain_setup.sh

Helper script for toolchain symbollic links installation using update-alternatives tool.

Usage: ./toolchain_setup.sh PATHFROM PATHTO PRIO [PREFIX]

    PATHFROM - where toolchain is located
    PATHTO - where symlinks will be placed
    PRIO - alternative priority for automatic mode
    PREFIX - optional toolchain prefix

Example:

    $ ./toolchain_setup.sh ~/gcc-arm-none-eabi-7-2017-q4-major/bin/ /usr/bin/ 0
