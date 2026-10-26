for lib in /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf/inst-switch/lib/*.a; do
    bad=$(/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S "$lib" 2>/dev/null | grep -E "rela\.rodata|rel\.rodata")
    if [ -n "$bad" ]; then
        echo "BAD (contains text relocations): $lib"
    else
        echo "OK: $lib"
    fi
done
