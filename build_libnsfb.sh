#!/bin/bash
set -e

export PATH=/opt/devkitpro/tools/bin:/opt/devkitpro/devkitA64/bin:/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-host/bin:/usr/bin:$PATH
export DEVKITPRO=/opt/devkitpro
export DEVKITA64=/opt/devkitpro/devkitA64
mkdir -p /f/tmp
export TMPDIR=/f/tmp
export TMP=/f/tmp
export TEMP=/f/tmp

PREFIX=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-switch
NSSHARED=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-host/share/netsurf-buildsystem
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:/opt/devkitpro/portlibs/switch/lib/pkgconfig
export PKG_CONFIG=/opt/devkitpro/portlibs/switch/bin/aarch64-none-elf-pkg-config

cd /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/workspace/libnsfb
make clean TARGET=sdl HOST=aarch64-none-elf PREFIX="$PREFIX" NSSHARED="$NSSHARED" || true
make TARGET=sdl HOST=aarch64-none-elf PREFIX="$PREFIX" NSSHARED="$NSSHARED" CC=aarch64-none-elf-gcc AR=aarch64-none-elf-ar CFLAGS="-fPIC -Iinclude -Isrc -I/opt/devkitpro/portlibs/switch/include -I/opt/devkitpro/portlibs/switch/include/SDL2 -D_GNU_SOURCE=1" install
echo "libnsfb build and install completed!"
