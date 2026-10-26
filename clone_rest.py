import subprocess
import os

repos = ['libutf8proc', 'libnsutils', 'libnspsl', 'libnslog', 'libnsfb']
ws = r'C:\Users\Wertk\.gemini\antigravity\scratch\switch-netsurf\workspace'
os.chdir(ws)

for r in repos:
    p = os.path.join(ws, r)
    if os.path.exists(p):
        import shutil
        shutil.rmtree(p, ignore_errors=True)
    url = f'git://git.netsurf-browser.org/{r}.git'
    print(f"Cloning {r} from {url}...")
    subprocess.run(['git', 'clone', '--depth', '1', url], check=True)
print("Finished!")
