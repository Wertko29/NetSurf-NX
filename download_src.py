import urllib.request
import time

url = 'https://download.netsurf-browser.org/netsurf/releases/source/netsurf-3.11-src.tar.gz'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla'})
print("Downloading netsurf-3.11-src.tar.gz...")
t0 = time.time()
with urllib.request.urlopen(req) as resp:
    data = resp.read()
print(f"Downloaded {len(data)} bytes in {time.time()-t0:.2f}s")
with open(r'C:\Users\Wertk\.gemini\antigravity\scratch\switch-netsurf\netsurf-3.11-src.tar.gz', 'wb') as f:
    f.write(data)
print("Saved!")
