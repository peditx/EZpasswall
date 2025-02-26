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

uci set system.@system[0].hostname='PeDitXOS'
uci commit system
/etc/init.d/system restart

sed -i 's/DISTRIB_ID=.*/DISTRIB_ID="PeDitXOS"/' /etc/openwrt_release
sed -i 's/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION="PeDitX OS telegram:@peditx"/' /etc/openwrt_release

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

# First Reform
opkg update
opkg install curl luci-compat 
opkg install luci-lib-ipkg
sleep 2
clear
opkg install luci-app-ttyd
sleep 2
opkg remove uci-mod-dashboard
sleep 2
opkg install whiptail
sleep 2

>/etc/banner

echo "   
 ______      _____   _      _    _     _____       
(_____ \    (____ \ (_)_   \ \  / /   / ___ \      
 _____) )___ _   \ \ _| |_  \ \/ /   | |   | | ___ 
|  ____/ _  ) |   | | |  _)  )  (    | |   | |/___)
| |   ( (/ /| |__/ /| | |__ / /\ \   | |___| |___ |
|_|    \____)_____/ |_|\___)_/  \_\   \_____/(___/ 
                                                   
                                                     P A S S W A L L                                                                                         
telegram : @PeDitX" >> /etc/banner

sleep 1

# Function to install a theme
install_theme() {
  local REPO_NAME=$1
  local THEME_NAME=$2

  echo "Processing $THEME_NAME..."

  # GitHub repository URL and package name
  LATEST_RELEASE_URL="https://api.github.com/repos/peditx/$REPO_NAME/releases/latest"
  IPK_URL=$(curl -s $LATEST_RELEASE_URL | grep "browser_download_url.*ipk" | cut -d '"' -f 4)

  # Check if the download link is found
  if [ -z "$IPK_URL" ]; then
    echo "Download link for the .ipk file of $THEME_NAME not found."
    return 1
  fi

  # Download the .ipk package
  echo "Downloading the latest version of $THEME_NAME..."
  wget -q $IPK_URL -O /tmp/$THEME_NAME.ipk

  # Install the .ipk package
  echo "Installing $THEME_NAME..."
  opkg install /tmp/$THEME_NAME.ipk

  # Clean up the downloaded file
  rm /tmp/$THEME_NAME.ipk

  echo "$THEME_NAME installed successfully."
}

# Install luci-theme-peditx
install_theme "luci-theme-peditx" "luci-theme-peditx"

# Install luci-theme-carbonpx
install_theme "luci-theme-carbonpx" "luci-theme-carbonpx"

opkg remove luci-theme-bootstrap --force-depends
# Restart the web service to apply the changes
echo "Restarting uhttpd service to apply changes..."
/etc/init.d/uhttpd restart

clear

### install themeswitch


echo -e "${GREEN}New theme Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}Android mobile app service Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}Ios native Web application Installed ✅ OK${NC}"
sleep 2
echo -e "${GREEN}New version of PeDitX theme Installed ✅ OK${NC}"
sleep 5


clear

rm -f setup.sh && wget https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/core/setup.sh && chmod 777 setup.sh

clear

##Scanning

. /etc/openwrt_release

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
echo " - System Ver : $DISTRIB_RELEASE"
echo " - System Arch : $DISTRIB_ARCH"

# RESULT=`echo "$DISTRIB_RELEASE" | grep -o 23 | sed -n '1p'`
sleep 5
# if [ "$RESULT" == "23" ]; then
sh setup.sh
