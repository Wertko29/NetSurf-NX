# NetSurf-NX (Nintendo Switch Port)

[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Nintendo%20Switch-e60012.svg)]()
[![Built with devkitPro](https://img.shields.io/badge/devkitPro-libnx-green.svg)](https://devkitpro.org/)

A native port of the lightweight and fast [NetSurf](https://www.netsurf-browser.org/) web browser for the Nintendo Switch homebrew platform.

---

## ✨ Features

- **Lightweight & Fast**: Powered by NetSurf's custom layout engine, optimized for low memory usage and quick page rendering.
- **Controls**:
  - Full Joy-Con and Pro Controller navigation (smooth virtual cursor + stick scrolling).
  - Multi-touch touchscreen gestures (tap to click, swipe to scroll).
  - Native Switch Software Keyboard (`swkbd`) integration for URL entry and form inputs.
- **Modern Standards**: CSS 2.1, HTML5 parsing, HTTPS/TLS support via mbedTLS/libcurl, image decoding (PNG, JPEG, WebP, GIF, BMP).
- **Built with Clean-Room Tools**: Compiled using the open-source [devkitPro](https://devkitpro.org/) / `libnx` toolchain with zero proprietary code.

---

## 🎮 Controls

| Button | Action |
| :--- | :--- |
| **Left Stick** | Move virtual mouse cursor |
| **Right Stick / D-Pad** | Scroll page Up / Down / Left / Right |
| **(A)** | Left Mouse Click / Follow link |
| **(B)** | Browser History: Back |
| **(X)** | Focus Address / URL bar |
| **(Y)** | Open Software Keyboard (`swkbd`) |
| **(L) / (R)** | Previous / Next Page |
| **(ZL)** | Right Mouse Click / Context menu |
| **Touchscreen** | Tap to click, drag to scroll |
| **(+) Plus** | Exit browser to Homebrew Menu |

---

## 📥 Installation

1. Download the latest release from the [Releases](https://github.com/your-username/NetSurf-NX/releases) page.
2. Extract the archive and copy `NetSurf.nro` to the `switch/NetSurf/` folder on your SD card:
   ```text
   sdmc:/switch/NetSurf/NetSurf.nro
   ```
3. Insert your SD card into your Nintendo Switch and launch **Homebrew Menu** (`hbmenu`).
4. Select **NetSurf** and launch it.

> [!NOTE]
> Launching via title redirection (holding `[R]` while launching a game) is recommended to give the browser access to full memory.

---

## 🛠️ Building from Source

### Prerequisites
- [devkitPro](https://devkitpro.org/) with `devkitA64` and `libnx`.
- Portlibs for Switch:
  ```bash
  dkp-pacman -S switch-sdl2 switch-sdl2_image switch-freetype switch-libpng switch-libjpeg-turbo switch-curl switch-mbedtls
  ```

### Build Steps
```bash
git clone https://github.com/your-username/NetSurf-NX.git
cd NetSurf-NX
./build_netsurf.sh
```

---

## ⚖️ Legal & Trademarks

- **NetSurf** is licensed under the [GNU General Public License v2 (GPL-2.0)](LICENSE).
- All third-party libraries (`SDL2`, `libcurl`, `mbedtls`, `libpng`, etc.) belong to their respective copyright holders.
- **Disclaimer**: This project is an independent homebrew application created for research and educational purposes. It is **NOT** affiliated with, endorsed by, sponsored by, or associated in any way with **Nintendo Co., Ltd.** or its subsidiaries.
- "Nintendo Switch" and "Joy-Con" are registered trademarks of Nintendo Co., Ltd.
- This software contains **NO** proprietary Nintendo SDK code, keys, firmware, or copyright-circumventing technologies.

---

## 💖 Credits & Acknowledgements

- [The NetSurf Project](https://www.netsurf-browser.org/) team for the incredible lightweight browser engine.
- [devkitPro](https://devkitpro.org/) and the `libnx` contributors for the Switch homebrew development environment.
- Author / Porter: **Wertko29**
