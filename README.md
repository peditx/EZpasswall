# EZPasswall
[![Visitor Badge](https://img.shields.io/badge/Chat%20on-Telegram-blue.svg)](https://t.me/peditx) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[**English**](README.md) | [**فارسی**](README_fa.md)



## How to Install EZPasswall

![Installation Image](https://github.com/peditx/iranIPS/blob/ffce5c185aecd61f1d92d100593ceecb2b905235/.files/lowspc/main/photo_2024-10-27_20-03-44.jpg?raw=true)

### System Requirements

- **CPU:** `>= 700 MHz`
- **RAM:** `>= 256 MB`



> ⚠ **Before Installation:** Ensure that `WAN Address` and `LAN Address` are not the same.  
> **Example:** 
> - WAN Address: `192.168.1.XXX`
> - LAN Address: `192.168.1.1`  
> Change the LAN Address to a different IP, such as `10.1.1.1`.



### Install Passwall

> 🔴 **Important:** For routers with `128 MB RAM`, please `downgrade` to [OpenWrt 22.03.3](https://archive.openwrt.org/releases/22.03.3/targets/). 🔴

Run the following command in OpenWrt remote SSH:

```bash
rm -f ezp.sh && wget https://github.com/peditx/EZpasswall/raw/refs/heads/main/ezp.sh && chmod 777 ezp.sh && sh ezp.sh
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
- Xiaomi AX3000T
- Xiaomi 4a Gigabit
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
- Smart installation of XRAY on temporary space if disk space is limited.
- Direct Iran IP & domain traffic (100%).
- Improved performance.
- New theme and logo design.
- Fixed WARP server connection.
- Default kill switch.
- XRAY Fragment tlshello | 1-3.




### Special Thanks

- [OpenWrt Team](https://github.com/openwrt)
- [Argon Theme](https://github.com/jerrykuku)
- [Passwall Team](https://github.com/xiaorouji)
- [V2Ray Team](https://github.com/v2ray)
- [peditxrt](https://github.com/peditx/PeDitXrt)
- [Amirhosein Choghaei](https://github.com/amirhosseinchoghaei)






[PeDitX](https://github.com/peditx) © 2024
