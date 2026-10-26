for lib in /opt/devkitpro/portlibs/switch/lib/*.a; do
    bad=$(/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S "$lib" 2>/dev/null | grep -E "rela\.rodata|rel\.rodata")
    if [ -n "$bad" ]; then
        echo "BAD portlib: $lib"
    fi
done
echo "Portlibs check finished."
