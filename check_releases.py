import urllib.request
import re

url = 'https://download.netsurf-browser.org/netsurf/releases/source/'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla'})
try:
    with urllib.request.urlopen(req) as resp:
        html = resp.read().decode('utf-8', errors='ignore')
    for m in re.finditer(r'href="([^"]+)"', html):
        print(m.group(1))
except Exception as e:
    print('Error:', e)
