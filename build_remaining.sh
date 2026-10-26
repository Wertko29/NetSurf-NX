#!/bin/bash
set -e

export PATH=/opt/devkitpro/tools/bin:/opt/devkitpro/devkitA64/bin:/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-host/bin:/usr/bin:$PATH
export DEVKITPRO=/opt/devkitpro
export DEVKITA64=/opt/devkitpro/devkitA64
PREFIX=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-switch
NSSHARED=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-host/share/netsurf-buildsystem
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig:/opt/devkitpro/portlibs/switch/lib/pkgconfig
export PKG_CONFIG=/opt/devkitpro/portlibs/switch/bin/aarch64-none-elf-pkg-config

WS=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/workspace

for lib in libnsgif libnsbmp libnsutils libnspsl libnslog; do
    echo "=== Quick building $lib ==="
    cd "$WS/$lib"
    make -j8 install HOST=aarch64-none-elf PREFIX="$PREFIX" NSSHARED="$NSSHARED" COMPONENT_TYPE=lib-static CC=aarch64-none-elf-gcc AR=aarch64-none-elf-ar
done
echo "All 5 libraries built successfully!"
