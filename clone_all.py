import subprocess
import os

repos = [
    'libwapcaplet', 'libparserutils', 'libhubbub', 'libdom', 'libcss',
    'libnsgif', 'libnsbmp', 'libutf8proc', 'libnsutils', 'libnspsl',
    'libnslog', 'libnsfb'
]

ws = r'C:\Users\Wertk\.gemini\antigravity\scratch\switch-netsurf\workspace'
os.chdir(ws)

for r in repos:
    if not os.path.exists(os.path.join(ws, r)):
        print(f"Cloning {r}...")
        subprocess.run(['git', 'clone', '--depth', '1', f'https://github.com/netsurf-browser/{r}.git'], check=True)
print("All cloned!")
