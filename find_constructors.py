import glob, subprocess

for lib in glob.glob(r"C:\Users\Wertk\.gemini\antigravity\scratch\switch-netsurf\inst-switch\lib\*.a"):
    res = subprocess.run([r"D:\devkitPro\devkitA64\bin\aarch64-none-elf-nm.exe", lib], capture_output=True, text=True)
    for line in res.stdout.splitlines():
        if "register_surface" in line:
            print("Found in", lib, ":", line)
