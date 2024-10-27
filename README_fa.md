# EZPasswall
[![Visitor Badge](https://img.shields.io/badge/Chat%20on-Telegram-blue.svg)](https://t.me/peditx) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

[**English**](README.md) | [**فارسی**](README_fa.md)



## چگونه EZPasswall را نصب کنیم

![نصب تصویر](https://github.com/peditx/iranIPS/blob/ffce5c185aecd61f1d92d100593ceecb2b905235/.files/lowspc/main/photo_2024-10-27_20-03-44.jpg?raw=true)

### الزامات سیستم

- **سی پی یو:** `>= 700 MHz`
- **رم:** `>= 256 MB



> ⚠  **قبل از نصب:** اطمینان حاصل کنید که `آدرس WAN` و `آدرس LAN` یکسان نیستند.  
> **مثال:** 

> - آدرس LAN: `192.168.1.1`  
> آدرس LAN را به یک IP دیگر تغییر دهید، مانند `10.1.1.1`.



### نصب Passwall

> 🔴 **مهم:** برای روترهایی با `128 MB RAM`، لطفاً به [OpenWrt 22.03.3](https://archive.openwrt.org/releases/22.03.3/targets/) `کاهش دهید`. 🔴

فرمان زیر را در SSH از به روی OpenWrt اجرا کنید:

```bash
rm -f ezp.sh && wget https://github.com/peditx/EZpasswall/raw/refs/heads/main/ezp.sh && chmod 777 ezp.sh && sh ezp.sh
```
**تمام شد!**



### پروتکل‌های پشتیبانی شده

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



### روترهای پیشنهادی

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



### ویژگی‌ها

- نصب خودکار کامل در یک مرحله.
- پشتیبانی از Passwall 1 و 2 بر روی یک روتر.
- نصب هوشمند XRAY در فضای موقت در صورت محدود بودن فضای دیسک.
- ترافیک مستقیم IP ها و دامنه های ایران (100%).
- بهبود عملکرد.
- طراحی تم و لوگو جدید.
- اتصال به سرور WARP .
- kill switch پیش‌فرض.
- XRAY Fragment tlshello | 1-3.




### تشکر ویژه

- [تیم OpenWrt](https://github.com/openwrt)
- [تم Argon](https://github.com/jerrykuku)
- [تیم Passwall](https://github.com/xiaorouji)
- [تیم V2Ray](https://github.com/v2ray)
- [peditxrt](https://github.com/peditx/PeDitXrt)
- [امیرحسین چغایی](https://github.com/amirhosseinchoghaei)






[PeDitX](https://github.com/peditx) © 2024
