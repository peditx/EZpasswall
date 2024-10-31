#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Check for OpenWrt or ImmortalWrt
if ! grep -qE "OpenWrt|ImmortalWrt" /etc/os-release; then
    os_info=$(cat /etc/os-release | grep '^PRETTY_NAME=' | cut -d'=' -f2 | tr -d '"')
    echo -e "${RED}You are using ${os_info}. It is recommended to use the X86Tools option to install the OpenWrt operating system, and then proceed with the Passwall installation options.${NC}"
    exit 1
fi

echo "Running as root..."
sleep 2
clear

uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit

/sbin/reload_config

cp ezp.sh /sbin/passwall

# First Reform
theme_url="https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-theme-argon_2.3_all.ipk"
config_url="https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-app-argon-config_0.9_all.ipk"
new_svg_url="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/app1.svg"
new_bg_url="https://raw.githubusercontent.com/peditx/iranIPS/a7ae889a9118cd91aa5d8e3e580628c2b6719a7b/.files/lowspc/main/peds.jpg"

svg_path="/www/luci-static/argon/img/argon.svg"
bg_path="/www/luci-static/argon/img/bg1.jpg"

theme_file="luci-theme-argon_2.3_all.ipk"
config_file="luci-app-argon-config_0.9_all.ipk"
new_svg_file="argon_replacement.svg"
new_bg_file="bg1_replacement.jpg"

# Update repositories and install dependencies
opkg update
opkg install curl luci-compat 
clear
opkg install luci-lib-ipkg
sleep 2
clear
opkg install luci-mod-dashboard
echo -e "${GREEN}Dashboard Installed ✅ OK${NC}"
sleep 2
clear

# Download and install theme and config files
echo "Downloading theme and config files..."
wget -O "$theme_file" "$theme_url" || { echo "Failed to download theme file"; exit 1; }
wget -O "$config_file" "$config_url" || { echo "Failed to download config file"; exit 1; }

# Install packages with architecture compatibility check
if ! opkg install "$theme_file"; then
    opkg install "$theme_file" --force-depends
fi

if ! opkg install "$config_file"; then
    opkg install "$config_file" --force-depends
fi

# Download new images
echo "Downloading new images..."
wget -O "$new_svg_file" "$new_svg_url" || { echo "Failed to download SVG file"; exit 1; }
wget -O "$new_bg_file" "$new_bg_url" || { echo "Failed to download background image"; exit 1; }

# Replace argon.svg
if [ -d "$(dirname "$svg_path")" ]; then
    mv "$new_svg_file" "$svg_path" && echo "argon.svg rebranded!" || echo "Failed to replace argon.svg"
else
    echo "$(dirname "$svg_path") not found"
fi

# Replace bg1.jpg
if [ -d "$(dirname "$bg_path")" ]; then
    mv "$new_bg_file" "$bg_path" && echo "bg1.jpg rebranded!" || echo "Failed to replace bg1.jpg"
else
    echo "$(dirname "$bg_path") not found"
fi

# Restart uhttpd service to apply changes
echo "Restarting uhttpd service..."
/etc/init.d/uhttpd restart

# Clean up downloaded files
echo "Cleaning up downloaded files..."
rm -f "$theme_file" "$config_file" "$new_svg_file" "$new_bg_file"

# Clear browser cache reminder
echo -e "Please clear your browser cache to see the updated images."

clear
echo -e "${GREEN}First reform ... done!${NC}"

# Verify installation and replacements
echo -e "\nVerification Results:"
if opkg list-installed | grep -q "luci-theme-argon"; then
    echo -e "${GREEN}Theme installed successfully ✅ OK${NC}"
else
    echo -e "${RED}Theme installation failed ❌ FAILED${NC}"
fi

if opkg list-installed | grep -q "luci-app-argon-config"; then
    echo -e "${GREEN}Config installed successfully ✅ OK${NC}"
else
    echo -e "${RED}Config installation failed ❌ FAILED${NC}"
fi

if [ -f "$svg_path" ]; then
    echo -e "${GREEN}SVG image replaced successfully ✅ OK${NC}"
else
    echo -e "${RED}SVG image replacement failed ❌ FAILED${NC}"
fi

if [ -f "$bg_path" ]; then
    echo -e "${GREEN}Background image replaced successfully ✅ OK${NC}"
else
    echo -e "${RED}Background image replacement failed ❌ FAILED${NC}"
fi

##Scanning

. /etc/openwrt_release

echo -e "${MAGENTA} 
_______           _______  __   __     __    __            __          
|       \         |       \|  \ |  \   |  \  |  \          |  \         
| ▓▓▓▓▓▓▓\ ______ | ▓▓▓▓▓▓▓\\▓▓_| ▓▓_  | ▓▓  | ▓▓ ______  _| ▓▓_        
| ▓▓__/ ▓▓/      \| ▓▓  | ▓▓  \   ▓▓ \  \▓▓\/  ▓▓/      \|   ▓▓ \       
| ▓▓    ▓▓  ▓▓▓▓▓▓\ ▓▓  | ▓▓ ▓▓\▓▓▓▓▓▓   >▓▓  ▓▓|  ▓▓▓▓▓▓\\▓▓▓▓▓▓       
| ▓▓▓▓▓▓▓| ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __ /  ▓▓▓▓\| ▓▓   \▓▓ | ▓▓ __      
| ▓▓     | ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ | ▓▓|  \  ▓▓ \▓▓\ ▓▓       | ▓▓|  \     
| ▓▓      \▓▓     \ ▓▓    ▓▓ ▓▓  \▓▓  ▓▓ ▓▓  | ▓▓ ▓▓        \▓▓  ▓▓     
 \▓▓       \▓▓▓▓▓▓▓\▓▓▓▓▓▓▓ \▓▓   \▓▓▓▓ \▓▓   \▓▓\▓▓         \▓▓▓▓      
                                      
                                                     P A S S W A L L ${NC}"
EPOL=`cat /tmp/sysinfo/model`
echo " - Model : $EPOL"
echo " - System Ver : $DISTRIB_RELEASE"
echo " - System Arch : $DISTRIB_ARCH"

# RESULT=`echo "$DISTRIB_RELEASE" | grep -o 23 | sed -n '1p'`

# if [ "$RESULT" == "23" ]; then


echo " "
RESULTT=`ls /etc/init.d/passwall 2>/dev/null`
if [ "$RESULTT" == "/etc/init.d/passwall" ]; then

echo -e "${YELLOW} > 4.${NC} ${GREEN} Update Your Passwall ${NC}"

 else
           
sleep 1

fi

RESULTTT=`ls /etc/init.d/passwall2 2>/dev/null`
if [ "$RESULTTT" == "/etc/init.d/passwall2" ]; then

echo -e "${YELLOW} > 5.${NC} ${GREEN} Update Your Passwall2 ${NC}"

 else
           
sleep 1

fi

echo -e "${GREEN} 1.${NC} ${CYAN} Install Passwall 1 ${NC}"
echo -e "${GREEN} 2.${NC} ${CYAN} Install Passwall 2 ${NC}"
echo -e "${GREEN} 3.${NC} ${BLUE} Install Passwall 1 + 2 ${NC}"
echo -e "${GREEN} 11.${NC} ${BLUE}Install Passwall 2 + Temporary core ${NC}"
echo -e "${GREEN} 6.${NC} ${MAGENTA} Easy Exroot For routers that have USB ${NC}"
echo -e "${GREEN} 7.${NC} ${RED} Extra tools ${NC}"
echo -e "${GREEN} 8.${NC} ${CYAN} X86Tools (To convert Linux x86 to router) ${NC}"
echo -e "${YELLOW} 9.${NC} ${YELLOW} CloudFlare IP Scanner ${NC}"
echo -e "${REF} 0.${NC} ${RED} EXIT ${NC}"
echo ""


echo " "
 read -p " -Select Passwall Option : " choice

    case $choice in

1)

echo "Installing Passwall 1 ..."

sleep 2

rm -f passwall.sh && wget https://github.com/peditx/iranIPS/raw/refs/heads/main/.files/passwall.sh && chmod 777 passwall.sh && sh passwall.sh


;;

2)
        
echo "Installing Passwall 2 ..."

sleep 2

rm -f passwall2.sh && wget https://github.com/peditx/iranIPS/raw/refs/heads/main/.files/passwall2.sh && chmod 777 passwall2.sh && sh passwall2.sh

 
;;

9)
        
echo "Installing CloudFlare IP SCAN ..."

opkg update

opkg install bash

opkg install curl

curl -ksSL https://gitlab.com/rwkgyg/cdnopw/raw/main/cdnopw.sh -o cdnopw.sh && bash cdnopw.sh
 
;;


4)
        
echo "Updating Passwall v1"

opkg update

opkg install luci-app-passwall
 
;;


5)
        
echo "Updating Passwall v2"

opkg update

opkg install luci-app-passwall2
 
;;


0)
            echo ""
            echo -e "${GREEN}Exiting...${NC}"
            exit 0

           read -s -n 1
           ;;

6)
        
echo "Easy Exroot Openwrt For routers that have USB ..."

opkg update

opkg install bash

opkg install curl

curl -ksSL https://github.com/peditx/ezexroot/raw/refs/heads/main/ezexroot.sh -o ezexroot.sh && bash ezexroot.sh
 
;;

7)
        
echo "Extra Tools (Wifi settings and cleanup memory) ..."

curl -ksSL https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/extras/extra.sh -o extra.sh && bash extra.sh
 
;;

8)
        
echo "Tools (To convert Linux x86 to router) ..."

curl -ksSL https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/x86/cmd.sh -o cmd.sh && bash cmd.sh
 
;;



 3)

echo "Installing Passwall 1 and 2 ..."

sleep 2

rm -f passwalldue.sh && wget https://github.com/peditx/iranIPS/raw/refs/heads/main/.files/passwalldue.sh && chmod 777 passwalldue.sh && sh passwalldue.sh


;;

11)

echo "Installing Passwall 2 With Temporary Core ..."

sleep 2

rm -f tempcore.sh && wget https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/core/tempcore.sh && chmod 777 tempcore.sh && sh tempcore.sh


;;

 *)
           echo "  Invalid option Selected ! "
           echo " "
           echo -e "  Press ${RED}ENTER${NC} to continue"
           exit 0
           read -s -n 1
           ;;
      esac
