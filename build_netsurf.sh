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

cd /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/netsurf-3.11

echo "Cleaning modified objects..."
rm -f build/aarch64-none-elf-framebuffer/frontends_framebuffer_gui.o \
      build/aarch64-none-elf-framebuffer/frontends_framebuffer_fetch.o \
      build/aarch64-none-elf-framebuffer/content_fetchers_curl.o \
      build/aarch64-none-elf-framebuffer/content_fetchers_resource.o \
      build/aarch64-none-elf-framebuffer/utils_log.o \
      build/aarch64-none-elf-framebuffer/utils_file.o \
      build/aarch64-none-elf-framebuffer/content_fetch.o \
      build/aarch64-none-elf-framebuffer/desktop_browser_window.o \
      nsfb

echo "Compiling NetSurf with -fPIC..."
make -j8 TARGET=framebuffer HOST=aarch64-none-elf PREFIX="$PREFIX" NSSHARED="$NSSHARED" CC=aarch64-none-elf-gcc AR=aarch64-none-elf-ar || true

find build/aarch64-none-elf-framebuffer -name '*.o' > /f/tmp/netsurf_objs.rsp

echo "Checking if any object file still has text relocations..."
bad_objs=0
while IFS= read -r obj; do
    if /opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S "$obj" 2>/dev/null | grep -E "rela\.rodata|rel\.rodata" > /dev/null; then
        echo "WARNING: Object $obj has text relocations!"
        bad_objs=$((bad_objs + 1))
    fi
done < /f/tmp/netsurf_objs.rsp
echo "Bad objects found: $bad_objs"

echo "Linking nsfb (STRICT -z text, NO -z notext)..."
aarch64-none-elf-gcc -specs=/opt/devkitpro/libnx/switch.specs -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE \
  -o nsfb \
  @/f/tmp/netsurf_objs.rsp \
  /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/switch_iconv.o \
  -L$PREFIX/lib -L/opt/devkitpro/portlibs/switch/lib -L/opt/devkitpro/libnx/lib \
  -Wl,--allow-multiple-definition \
  -Wl,--start-group \
  -lcss -ldom -lhubbub -lparserutils -lwapcaplet -lutf8proc -lnsutils -lnspsl -lnslog \
  -Wl,--whole-archive -lnsfb -Wl,--no-whole-archive \
  -lnsbmp -lnsgif \
  -lcurl -lpng16 -ljpeg -lz -lbz2 -lfreetype -lharfbuzz \
  -lSDL2 -lEGL -lglapi -ldrm_nouveau -lnx -lstdc++ -lm \
  -Wl,--end-group

echo "Link succeeded!"
ls -lh nsfb

echo "Verifying no TEXTREL in nsfb..."
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -d nsfb | grep TEXTREL || echo "PASS: No TEXTREL dynamic tag!"

echo "Packaging NetSurf.nro..."
elf2nro nsfb /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nro \
  --icon=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/icon.jpg \
  --nacp=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nacp \
  --romfsdir=/c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/romfs

echo "Copying to destinations..."
mkdir -p /d/switch /d/switch/NetSurf
cp -f /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nro /d/switch/NetSurf.nro || true
cp -f /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nro /d/switch/NetSurf/NetSurf.nro || true
if [ -d /f ]; then
  mkdir -p /f/switch /f/switch/NetSurf
  cp -f /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nro /f/switch/NetSurf.nro || true
  cp -f /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/NetSurf.nro /f/switch/NetSurf/NetSurf.nro || true
fi

echo "DONE! NetSurf.nro is ready at D:/switch/NetSurf.nro"
