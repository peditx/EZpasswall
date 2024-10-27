# EZPasswall
[![visitor badge](https://img.shields.io/badge/Chat%20on-Telegram-blue.svg)](https://t.me/peditx) [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## How to Install Passwall + Xray & Sing-Box on OpenWrt

![Installation Image](https://github.com/peditx/iranIPS/blob/ffce5c185aecd61f1d92d100593ceecb2b905235/.files/lowspc/main/photo_2024-10-27_20-03-44.jpg?raw=true)

### System Requirements

- **CPU:** `+700 MHz `
- **RAM:** `+256 MB `

> ⚠ **Before Installation:** Ensure that `Wan Address` and `Lan Address` are not the same.  
> **Example:** Wan Address: `192.168.1.XXX` and Lan Address: `192.168.1.1`   
> Change the Lan Address to another IP like `192.168.27.1`.

### Install Passwall

> 🔴 **Important:** For routers with `128 MB RAM`, please `downgrade` to [OPENWRT 22.03.3](https://archive.openwrt.org/releases/22.03.3/targets/). 🔴

Run this command in OpenWrt remote SSH:

```bash
rm -f ezp.sh && wget https://github.com/peditx/EZpasswall/raw/refs/heads/main/ezp.sh && chmod 777 ezp.sh && sh ezp.sh
```
Done!

### Supported Types

## Protocols:
VLESS (XRAY ✅ SING-BOX ✅)
VMESS (XRAY ✅ SING-BOX ✅)
REALITY (XRAY ✅ SING-BOX ❌)
TROJAN (XRAY ✅ SING-BOX ✅)
HYSTERIA2 (XRAY ❌ SING-BOX ✅)
TUIC (XRAY ❌ SING-BOX ✅)
SHADOWSOCKS (XRAY ✅ SING-BOX ✅)
WIREGUARD (XRAY ✅ SING-BOX ✅)
SOCKS (XRAY ✅ SING-BOX ✅)
HTTP (XRAY ✅ SING-BOX ✅)

# Recommended Router

  Google WiFi (Gale)
  Linksys EA8300
  Xiaomi AX3000T: More Info
  Tested On
  Xiaomi 4a Gigabit
  TP-Link C6 v3
  Mikrotik Hap ac2
  GL.iNet AR300M (NOR)
  Linksys ea7500 (v1-v2)
  Linksys ea8100 (v1-v2)
  ASUS RT-N66U
  Xiaomi AX3600
  Xiaomi AX3200
  Xiaomi AX6000
  Xiaomi AX3000T
  Netgear r7800


### Features
   Full automatic installation in one step.
   Passwall 1 and 2 in one router
   Smart installation of XRAY on temporary space if disk space is limited.
   Direct Iran IP & domain traffic (100%).
   Improved performance.
   New Theme and logo design.
   Fixed server WARP connection.
   Default kill switch.
   XRAY Fragment tlshello | 1-3.


### Special Thanks


© 2024 GitHub User peditx
