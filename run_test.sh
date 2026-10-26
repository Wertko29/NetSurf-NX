cd /c/Users/Wertk/.gemini/antigravity/scratch/switch-netsurf
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-gcc -fPIE -c -o test_pie.o test_pic.c
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-gcc -fPIC -c -o test_pic.o test_pic.c
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-gcc -c -o test_nopic.o test_pic.c

echo "=== No PIC ==="
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S test_nopic.o | grep "rodata\|data"
echo "=== PIE ==="
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S test_pie.o | grep "rodata\|data"
echo "=== PIC ==="
/opt/devkitpro/devkitA64/bin/aarch64-none-elf-readelf -S test_pic.o | grep "rodata\|data"
