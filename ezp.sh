#!/bin/sh

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "Running as root..."
sleep 2
clear

# Set system settings
uci set system.@system[0].zonename='Asia/Tehran'
uci set system.@system[0].timezone='<+0330>-3:30'
uci commit

uci set system.@system[0].hostname='MHKWRT'
uci commit system
/etc/init.d/system restart

# Update OpenWrt distribution info
sed -i 's/DISTRIB_ID=.*/DISTRIB_ID="MHKWRT"/' /etc/os-release
sed -i 's/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION="MHKWRT"/' /etc/os-release

/sbin/reload_config

cp ezp.sh /sbin/passwall

echo -e "${MAGENTA} 
 ______      _____   _      _    _     _____       
(_____ \    (____ \ (_)_   \ \  / /   / ___ \      
 _____) )___ _   \ \ _| |_  \ \/ /   | |   | | ___ 
|  ____/ _  ) |   | | |  _)  )  (    | |   | |/___)
| |   ( (/ /| |__/ /| | |__ / /\ \   | |___| |___ |
|_|    \____)_____/ |_|\___)_/  \_\   \_____/(___/ 
                                                   
                                              E Z P A S S W A L L v2 ${NC}"
sleep 3

# Install dependencies using apk
apk update
apk add curl luci-compat 
apk add luci-lib-ipkg
sleep 2
clear
apk add luci-app-ttyd
sleep 2
apk del uci-mod-dashboard
sleep 2
apk add whiptail
sleep 2

# Function to install themes from original GitHub repositories
install_theme() {
  local REPO_OWNER=$1
  local REPO_NAME=$2
  local THEME_NAME=$3

  echo "Processing $THEME_NAME..."

  # Get the latest release
  LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"
  IPK_URL=$(curl -s $LATEST_RELEASE_URL | grep "browser_download_url.*ipk" | cut -d '"' -f 4)

  if [ -z "$IPK_URL" ]; then
    echo "Download link for the .ipk file of $THEME_NAME not found."
    return 1
  fi

  wget -q $IPK_URL -O /tmp/$THEME_NAME.ipk
  apk add --allow-untrusted /tmp/$THEME_NAME.ipk
  rm /tmp/$THEME_NAME.ipk
  echo "$THEME_NAME installed successfully."
}

# Install themes from original repositories
install_theme "jerrykuku" "luci-theme-argon" "luci-theme-argon"
install_theme "openwrt-develop" "luci-theme-bootstrap-mod" "luci-theme-bootstrap-mod"

apk del luci-theme-bootstrap --force
/etc/init.d/uhttpd restart

clear

# Messages
echo -e "${GREEN}New theme Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}Android mobile app service Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}iOS native Web application Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}New version of MHKWRT theme Installed ✅ OK${NC}"
sleep 5

clear

rm -f setup.sh && wget https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/core/setup.sh && chmod 777 setup.sh

clear

# Scanning System Info
. /etc/os-release

echo -e "${MAGENTA} 
 ______      _____   _      _    _     _____       
(_____ \    (____ \ (_)_   \ \  / /   / ___ \      
 _____) )___ _   \ \ _| |_  \ \/ /   | |   | | ___ 
|  ____/ _  ) |   | | |  _)  )  (    | |   | |/___)
| |   ( (/ /| |__/ /| | |__ / /\ \   | |___| |___ |
|_|    \____)_____/ |_|\___)_/  \_\   \_____/(___/ 
                                                   
                                              E Z P A S S W A L L v2 ${NC}"
EPOL=`cat /tmp/sysinfo/model`
echo " - Model : $EPOL"
echo " - System Ver : $VERSION_ID"
echo " - System Arch : $ARCH"

sleep 5
sh setup.sh
