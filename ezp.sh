#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo "Running as root..."
sleep 2
clear

uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit

/sbin/reload_config

cp passwallx.sh /sbin/passwall

##FirstReform
rm -f /tmp/luci-theme-argon_2.3_all.ipk  wget -O /tmp/luci-theme-argon_2.3_all.ipk https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-theme-argon_2.3_all.ipk
opkg install /tmp/luci-theme-argon_2.3_all.ipk
rm -f luci-theme-argon_2.3_all.ipk
rm -f /tmp/luci-app-argon-config_0.9_all.ipk wget -O /tmp/luci-app-argon-config_0.9_all.ipk https://github.com/peditx/PeDitXrt-rebirth/raw/main/apps/luci-app-argon-config_0.9_all.ipk
opkg install /tmp/luci-app-argon-config_0.9_all.ipk
rm -f luci-app-argon-config_0.9_all.ipk

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

echo -e "${YELLOW} 1.${NC} ${CYAN} Install Passwall 1 ${NC}"
echo -e "${YELLOW} 2.${NC} ${CYAN} Install Passwall 2 ${NC}"
echo -e "${YELLOW} 3.${NC} ${CYAN} Install Passwall 1 + 2 ${NC}"
echo -e "${YELLOW} 9.${NC} ${YELLOW} CloudFlare IP Scanner ${NC}"
echo -e "${YELLOW} 6.${NC} ${RED} EXIT ${NC}"
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


6)
            echo ""
            echo -e "${GREEN}Exiting...${NC}"
            exit 0

           read -s -n 1
           ;;

 3)

echo "Installing Passwall 1 and 2 ..."

sleep 2

rm -f passwalldue.sh && wget https://github.com/peditx/iranIPS/raw/refs/heads/main/.files/passwalldue.sh && chmod 777 passwalldue.sh && sh passwalldue.sh


;;


 *)
           echo "  Invalid option Selected ! "
           echo " "
           echo -e "  Press ${RED}ENTER${NC} to continue"
           exit 0
           read -s -n 1
           ;;
      esac
