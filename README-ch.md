# EZPasswall (简体中文)

[![访客徽章](https://img.shields.io/badge/Chat%20on-Telegram-blue.svg)](https://t.me/peditx) [![许可: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[**English**](README.md) | [**فارسی**](README_fa.md) | [**简体中文**](README-ch.md) | [**Русский**](README_ru.md)

### EZPasswall脚本是什么？

该脚本允许您使用现代化和简洁的界面轻松优化OpenWrt设备，支持OpenVPN、Xray、V2Ray、WireGuard、Cloudflare Warp等协议。您还可以单独安装或同时安装Passwall 1和Passwall 2，以享受稳定的互联网连接和分段的、连续的流量。该脚本将随着时间的推移不断改进。

此致  
[PeDitX](https://github.com/peditx)

## 如何安装EZPasswall
![安装图片](https://github.com/peditx/iranIPS/blob/1f05bc52dae7b573742e0bcccf8430c8a46b94e4/.files/lowspc/main/photo_2024-10-27_21-15-16.jpg?raw=true)
![安装图片](https://github.com/peditx/iranIPS/blob/ffce5c185aecd61f1d92d100593ceecb2b905235/.files/lowspc/main/photo_2024-10-27_20-03-44.jpg?raw=true)
![安装图片](https://github.com/peditx/iranIPS/blob/main/.files/lowspc/main/new/photo_2024-10-31_17-15-33.jpg?raw=true)
![安装图片](https://github.com/peditx/iranIPS/blob/main/.files/lowspc/main/new/photo_2024-10-31_17-16-35.jpg?raw=true)
![安装图片](https://github.com/peditx/iranIPS/blob/main/.files/lowspc/main/new/photo_2024-10-31_17-17-44.jpg?raw=true)

### 路由器的系统要求

- **CPU:** `>= 700 MHz`
- **内存:** `>= 256 MB`

### 我们的最佳路由器推荐

- Google WiFi (Gale)
- Linksys EA8100
- Linksys EA8300
- Linksys E8450
- Belkin rt3200
- GL-iNet GL-A1300

### 计算机的最低系统要求
- **CPU:** `AMD或Intel`
- **内存:** `2 GB`
- **操作系统:** `Linux Ubuntu 20.04`

> ⚠ **安装前请注意:** 确保 `WAN 地址` 和 `LAN 地址` 不相同。  
> **示例:** 
> - WAN 地址: `192.168.1.XXX`
> - LAN 地址: `192.168.1.1`  
> 请将 LAN 地址更改为其他IP，例如 `10.1.1.1`。

### 安装Passwall

> 🔴 **重要:** 对于 `128 MB 内存` 的路由器，请降级到 [OpenWrt 22.03.3](https://archive.openwrt.org/releases/22.03.3/targets/)。🔴

在OpenWrt远程SSH中运行以下命令：

```bash
opkg update
opkg install coreutils-base64 bash
rm -f ezp.sh && wget -qO - https://raw.githubusercontent.com/peditx/EZpasswall/refs/heads/main/ezp.b64 | awk '{print $1}' | base64 -d > ezp.sh && chmod +x ezp.sh && sh ezp.sh

```

如果您希望使用Linux到OpenWrt的转换服务，只需在远程SSH中输入以下命令：

```bash
sudo apt-get update
sudo apt-get install curl
rm -f *.sh && wget https://raw.githubusercontent.com/peditx/easywrt/refs/heads/main/start.sh && bash start.sh

```
或者（对于 X86/X86-64），只需下载并将此 .iso 文件写入可启动的闪存，然后输入 start.sh 命令：

```bash
https://github.com/peditx/easywrt/releases/download/V101/PeDitXOs-101.iso

```

***如果您在从 SourceForge、GitHub 或 OpenWrt 网站下载软件包时遇到问题，或者代码执行失败，请使用以下命令测试不同的主机。最后，按数字 `6` 运行脚本。***

```bash
rm -f host.sh && wget -O host.sh https://raw.githubusercontent.com/peditx/EZpasswall/refs/heads/main/host.sh && chmod +x host.sh && ./host.sh
```

**完成!**

### 支持的协议

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

### 推荐路由器

- Google WiFi (Gale)
- Linksys EA8300
- Linksys E8450
- Belkin rt3200
- GL-iNet GL-A1300
- 小米 AX3000T
- ~~小米 4a 千兆版~~
- TP-Link C6 v3
- Mikrotik Hap ac2
- GL.iNet AR300M (NOR)
- Linksys EA7500 (v1-v2)
- Linksys EA8100 (v1-v2)
- ASUS RT-N66U
- 小米 AX3600
- 小米 AX3200
- 小米 AX6000
- Netgear R7800

### 功能

- 一步全自动安装
- 支持在同一台路由器上安装Passwall 1和2
- 对有USB接口的路由器进行一键exroot安装
- X86工具将Linux x86/x86-64转换为OpenWRT、ImmortalWRT、PeDitXRT、MikroTik或适用于无直接安装功能的系统的自定义操作系统
- 在“附加工具”中简单输入SSID和密码即可快速设置Wi-Fi
- 在“附加工具”中一键清除已用内存
- 在有超过512 MB存储空间的路由器和瘦客户机上安装其他包，如OpenVPN、Sing-box、SoftEther、IP分离与Sing-box等
- 在磁盘空间有限时智能安装XRAY到临时空间
- 100%引导伊朗IP和域流量
- 性能改进
- 新主题和标志设计
- 修复WARP服务器连接
- 默认Kill Switch
- XRAY分段 tlshello | 1-3

### 特别感谢

- [OpenWrt团队](https://github.com/openwrt)
- [Argon主题](https://github.com/jerrykuku)
- [Passwall团队](https://github.com/xiaorouji)
- [V2Ray团队](https://github.com/v2ray)
- [PeDitXrt](https://github.com/peditx/PeDitXrt)
- [Mohamadreza Broujerdi](https://t.me/MR13_B)
- [Amirhosein Choghaei](https://github.com/amirhosseinchoghaei)
- [Mashkouk](https://github.com/mashkouk)

[PeDitX](https://github.com/peditx) © 2024
