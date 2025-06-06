# EZPasswall
[![Visitor Badge](https://img.shields.io/badge/Chat%20on-Telegram-blue.svg)](https://t.me/peditx) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[**English**](README.md) | [**فارسی**](README_fa.md) | [**简体中文**](README-ch.md) | [**Русский**](README_ru.md)

### What is the EZPasswall script?

  This script allows you to easily optimize your OpenWrt device with a modern and simple interface, including support for protocols like OpenVPN, Xray, V2Ray, WireGuard, Cloudflare Warp, and more. You can also install Passwall 1 and Passwall 2 (either separately or both) and enjoy a stable internet connection with segmented and continuous traffic.
  This script will be continuously improved over time.

  Yours sincerely,
  [PeDitX](https://github.com/peditx)

## How to Install EZPasswall
![Installation Image](https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/photo_2024-10-27_21-15-16.jpg)
![Installation Image](https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/photo_2024-10-27_20-03-44.jpg)
![Installation Image](https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/set1.png)
![Installation Image](https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/set2.png)
![Installation Image](https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/set3.png)

## Android controller app
[![Download for Android](https://img.shields.io/badge/Download%20for-Android-green?style=for-the-badge&logo=android)](https://github.com/peditx/EZpasswall/releases/tag/1.0.4)

⚠ You need the EZpasswall script to use this app for controlling your router.

### System Requirements for routers

- **CPU:** `>= 700 MHz`
- **RAM:** `>= 256 MB`

### The best router recommendations from us

- Google WiFi (Gale)
- Linksys EA8100
- Linksys EA8300
- Linksys E8450
- Belkin rt3200
- GL-iNet GL-A1300

### Minimum System Requirements for Computer
- **CPU:** `AMD or Intel`
- **RAM:** `2 GB`
- **Operating System:** `Linux Ubuntu 20.04`


> ⚠ **Before Installation:** Ensure that `WAN Address` and `LAN Address` are not the same.  
> **Example:** 
> - WAN Address: `192.168.1.XXX`
> - LAN Address: `192.168.1.1`  
> Change the LAN Address to a different IP, such as `10.1.1.1`.



### Install Passwall

> 🔴 **Important:** For routers with `128 MB RAM`, please `downgrade` to [OpenWrt 22.03.3](https://archive.openwrt.org/releases/22.03.3/targets/). 🔴

Run the following command in OpenWrt remote SSH:

```bash
rm -f ezp.sh && wget https://raw.githubusercontent.com/peditx/EZpasswall/refs/heads/main/ezp.sh && chmod -X ezp.sh && sh ezp.sh

```

If you want to use the Linux-to-OpenWrt conversion service, simply enter the following command in remote SSH:

```bash
sudo apt-get update
sudo apt-get install curl
rm -f *.sh && wget https://raw.githubusercontent.com/peditx/easywrt/refs/heads/main/start.sh && bash start.sh

```

Or (in X86/X86-64) just download and bootable flash with this .iso file and type start.sh:

```bash
https://github.com/peditx/easywrt/releases/download/V101/PeDitXOs-101.iso

```

***If you encounter issues downloading packages from SourceForge, GitHub, or the OpenWrt site, or if code execution fails, use the command below to test different hosts. Finally, press number `6` to run the script.***

```bash
rm -f host.sh && wget -O host.sh https://raw.githubusercontent.com/peditx/EZpasswall/refs/heads/main/host.sh && chmod +x host.sh && ./host.sh

```

**Done!**



### Supported Protocols

- **VLESS:** (XRAY ✅, SING-BOX ✅)
- **VMESS:** (XRAY ✅, SING-BOX ✅)
- **REALITY:** (XRAY ✅, SING-BOX ❌)
- **TROJAN:** (XRAY ✅, SING-BOX ✅)
- **HYSTERIA2:** (XRAY ❌, SING-BOX ✅)
- **TUIC:** (XRAY ❌, SING-BOX ✅)
- **SHADOWSOCKS:** (XRAY ✅, SING-BOX ✅)
- **WIREGUARD:** (XRAY ✅, SING-BOX ✅)
- **SOCKS:** (XRAY ✅, SING-BOX ✅)
- **HTTP:** (XRAY ✅, SING-BOX ✅)



### Recommended Routers

- Google WiFi (Gale)
- Linksys EA8300
- Linksys E8450
- Belkin rt3200
- GL-iNet GL-A1300
- Xiaomi AX3000T
- ~~Xiaomi 4a Gigabit~~
- TP-Link C6 v3
- Mikrotik Hap ac2
- GL.iNet AR300M (NOR)
- Linksys EA7500 (v1-v2)
- Linksys EA8100 (v1-v2)
- ASUS RT-N66U
- Xiaomi AX3600
- Xiaomi AX3200
- Xiaomi AX6000
- Netgear R7800



### Features

- Full automatic installation in one step.
- Supports Passwall 1 and 2 on one router.
- Easy one click exroot installion on routers that have USB port.
- X86tools for converting Linux x86/x86-64 to OpenWRT, ImmortalWRT, PeDitXRT, MikroTik, or custom operating systems for systems without direct installation.
- Quick Wi-Fi setup by simply entering the SSID and password in the Extra Tools section
- Clear used memory with just one click in the Extra Tools section
- Install additional packages such as OpenVPN, Sing-box, SoftEther, and IP separation with Sing-box, etc., for routers and thin clients with storage space greater than 512 MB in the Extra Tools section
- Smart installation of XRAY on temporary space if disk space is limited.
- Direct Iran IP & domain traffic (100%).
- Improved performance.
- New theme and logo design.
- Fixed WARP server connection.
- Default kill switch.
- XRAY Fragment tlshello | 1-3.




### Special Thanks

- [OpenWrt Team](https://github.com/openwrt)
- [PeDitX Theme](https://github.com/peditx/luci-theme-peditx)
- [Passwall Team](https://github.com/xiaorouji)
- [V2Ray Team](https://github.com/v2ray)
- [PeDitXrt](https://github.com/peditx/PeDitXrt)
- [Mohamadreza Broujerdi](https://t.me/MR13_B)
- [Mashkouk](https://github.com/mashkouk)






[PeDitX](https://github.com/peditx) © 2024
