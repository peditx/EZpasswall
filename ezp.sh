#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

rm -f /etc/hosts
echo "185.199.111.133 raw.githubusercontent.com" >> /etc/hosts
echo "216.105.38.12 master.dl.sourceforge.net" >> /etc/hosts
echo "151.101.2.132 downloads.openwrt.org" >> /etc/hosts
echo "140.82.121.3 github.com" >> /etc/hosts

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
favicon_url="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/lowspc/main/favicon.ico"

svg_path="/www/luci-static/argon/img/argon.svg"
bg_path="/www/luci-static/argon/img/bg1.jpg"
favicon_path="/www/luci-static/argon/favicon.ico"

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

# Download and replace favicon.ico
echo "Downloading favicon..."
wget -O "$favicon_path" "$favicon_url" || { echo "Failed to download favicon"; exit 1; }
echo "Favicon downloaded and replaced!"


# Restart uhttpd service to apply changes
echo "Restarting uhttpd service..."
/etc/init.d/uhttpd restart

# Setup PWA ability
clear

# Define variables
HEADER_FILE="/usr/lib/lua/luci/view/themes/argon/header.htm"
HEADER_LOGIN_FILE="/usr/lib/lua/luci/view/themes/argon/header_login.htm"
ICONS_ZIP_URL="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/favicon.zip"
TEMP_DIR="/tmp/touch-icons"
EXTRACT_DIR="/www/luci-static/argon/icons"
FAVICON_FILE="/www/luci-static/argon/favicon.ico"
MANIFEST_FILE="/www/luci-static/argon/manifest.json"

# Download the icons zip file
echo "Downloading PWA icons..."
wget -q "$ICONS_ZIP_URL" -O /tmp/touch-icons.zip

# Extract icons
echo "Extracting touch icons..."
unzip -q /tmp/touch-icons.zip -d $TEMP_DIR

# Create the destination directory if it doesn't exist
echo "Creating destination directory..."
mkdir -p $EXTRACT_DIR

# Move extracted icons to the destination directory
echo "Moving icons to destination..."
mv $TEMP_DIR/* $EXTRACT_DIR/

# Replace favicon.ico with the one from icons folder
echo "Replacing favicon.ico..."
cp "$EXTRACT_DIR/favicon.ico" "$FAVICON_FILE"

# Create the manifest.json file
echo "Creating manifest.json..."
cat > $MANIFEST_FILE <<EOL
{
  "name": "PeDitXrt PWA",
  "short_name": "PeDitXrt",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#4CAF50",
  "icons": [
    {
      "src": "/luci-static/argon/icons/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any maskable"
    },
    {
      "src": "/luci-static/argon/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any maskable"
    },
    {
      "src": "/luci-static/argon/icons/apple-touch-icon.png",
      "sizes": "180x180",
      "type": "image/png"
    }
  ]
}
EOL

# Update the HTML header for PWA in header.htm
echo "Updating HTML header for PWA..."
sed -i 's|<%=media%>/icon/|/luci-static/argon/icons/|g' "$HEADER_FILE"
sed -i "s|</head>|<link rel=\"manifest\" href=\"/luci-static/argon/manifest.json\">\n<link rel=\"icon\" type=\"image/png\" sizes=\"192x192\" href=\"/luci-static/argon/icons/icon-192x192.png\">\n<link rel=\"icon\" type=\"image/png\" sizes=\"512x512\" href=\"/luci-static/argon/icons/icon-512x512.png\">\n<link rel=\"apple-touch-icon\" href=\"/luci-static/argon/icons/apple-touch-icon.png\">\n</head>|" "$HEADER_FILE"

# Update the HTML header for PWA in header_login.htm
echo "Updating login header for PWA..."
sed -i 's|<%=media%>/icon/|/luci-static/argon/icons/|g' "$HEADER_LOGIN_FILE"
sed -i "s|</head>|<link rel=\"manifest\" href=\"/luci-static/argon/manifest.json\">\n<link rel=\"icon\" type=\"image/png\" sizes=\"192x192\" href=\"/luci-static/argon/icons/icon-192x192.png\">\n<link rel=\"icon\" type=\"image/png\" sizes=\"512x512\" href=\"/luci-static/argon/icons/icon-512x512.png\">\n<link rel=\"apple-touch-icon\" href=\"/luci-static/argon/icons/apple-touch-icon.png\">\n</head>|" "$HEADER_LOGIN_FILE"

# Add a popup to login page with custom styling
echo "Adding popup to login page..."
cat >> /usr/lib/lua/luci/view/themes/argon/header_login.htm <<EOL
<script>
  // Check if the popup has already been shown
  if (!localStorage.getItem('pwa_popup_shown')) {
    // Function to show the popup
    function showPopup() {
      var popup = document.createElement("div");
      popup.id = "add-to-home-popup";
      popup.innerHTML = "<p>If you want to use this app as a native app, please add it to your home screen.</p><button onclick='this.parentElement.style.display=\"none\";'>Close</button>";
      
      // Apply the styles
      popup.style.position = "fixed";
      popup.style.left = "50%";
      popup.style.bottom = "20px";
      popup.style.transform = "translateX(-50%)";
      popup.style.backgroundColor = "rgba(0, 0, 0, 0.75)";
      popup.style.color = "#fff";
      popup.style.padding = "10px 20px";
      popup.style.borderRadius = "8px";
      popup.style.zIndex = "1000";
      popup.style.textAlign = "center";
      popup.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.5)";
      
      document.body.appendChild(popup);
    }

    // Check if it's iOS and show the popup
    if (navigator.userAgent.match(/iPhone|iPad|iPod/)) {
      showPopup();
    }

    // Mark the popup as shown
    localStorage.setItem('pwa_popup_shown', 'true');
  }
</script>
EOL

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf $TEMP_DIR /tmp/touch-icons.zip

clear

# Final message
echo "PWA setup completed successfully."

sleep 3
############

# install Button 

clear

# Path to the footer.htm file
FOOTER_PATH="/usr/lib/lua/luci/view/themes/argon/footer.htm"

# Verify if the footer.htm file exists
if [ ! -f "$FOOTER_PATH" ]; then
    echo "footer.htm not found at $FOOTER_PATH, please check the path and try again."
    exit 1
fi

# Create the buttons folder if it doesn't exist
BUTTONS_FOLDER="/www/luci-static/argon/button"
mkdir -p "$BUTTONS_FOLDER"

# Download the image for the apple-touch-icon
IMAGE_URL_1="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/button/apple-touch-icon.png"
IMAGE_PATH_1="$BUTTONS_FOLDER/apple-touch-icon.png"

# Download the image for the passwall2 button
IMAGE_URL_2="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/button/passwall2.png"
IMAGE_PATH_2="$BUTTONS_FOLDER/passwall2.png"

# Download the image for the dashboard button
IMAGE_URL_3="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/button/rm.png"
IMAGE_PATH_3="$BUTTONS_FOLDER/rm.png"

# Download the image for the reboot button
IMAGE_URL_4="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/button/reboot.png"
IMAGE_PATH_4="$BUTTONS_FOLDER/reboot.png"

# Download the image for the telegram button
IMAGE_URL_5="https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/ui/button/tl.png"
IMAGE_PATH_5="$BUTTONS_FOLDER/tl.png"

# Use wget to download the images
echo "Downloading images..."
wget -q "$IMAGE_URL_1" -O "$IMAGE_PATH_1" && echo "Downloaded apple-touch-icon image" || echo "Failed to download apple-touch-icon image"
wget -q "$IMAGE_URL_2" -O "$IMAGE_PATH_2" && echo "Downloaded passwall2 image" || echo "Failed to download passwall2 image"
wget -q "$IMAGE_URL_3" -O "$IMAGE_PATH_3" && echo "Downloaded dashboard image" || echo "Failed to download dashboard image"
wget -q "$IMAGE_URL_4" -O "$IMAGE_PATH_4" && echo "Downloaded reboot image" || echo "Failed to download reboot image"
wget -q "$IMAGE_URL_5" -O "$IMAGE_PATH_5" && echo "Downloaded telegram image" || echo "Failed to download telegram image"

# Verify if the images were downloaded successfully
if [ ! -f "$IMAGE_PATH_1" ]; then
    echo "Failed to download image for apple-touch-icon from $IMAGE_URL_1"
    exit 1
fi

if [ ! -f "$IMAGE_PATH_2" ]; then
    echo "Failed to download image for passwall2 button from $IMAGE_URL_2"
    exit 1
fi

if [ ! -f "$IMAGE_PATH_3" ]; then
    echo "Failed to download image for dashboard button from $IMAGE_URL_3"
    exit 1
fi

if [ ! -f "$IMAGE_PATH_4" ]; then
    echo "Failed to download image for reboot button from $IMAGE_URL_4"
    exit 1
fi

if [ ! -f "$IMAGE_PATH_5" ]; then
    echo "Failed to download image for telegram button from $IMAGE_URL_5"
    exit 1
fi

# Add CSS and HTML for floating button with local image in LuCI footer
cat << EOF >> "$FOOTER_PATH"
<style>
    #floating-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 80px;  /* Adjusted size */
        height: 80px;  /* Adjusted size */
        border-radius: 50%;
        box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.3);
        z-index: 1000;
        cursor: pointer;
        background-color: transparent;
        border: none;
    }

    #floating-button img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover; /* Make image cover the button */
    }

    .sub-buttons {
        position: fixed;
        bottom: -240px; /* Initially out of view, 3 icon sizes below */
        right: 20px;
        z-index: 999;
        flex-direction: column;
        display: flex;
        align-items: center;
        transform: translateY(100%); /* Initially out of view */
        transition: transform 0.3s ease-in-out;
        overflow: hidden;
    }

    .sub-buttons button {
        width: 80px;  /* Adjusted size */
        height: 80px;  /* Adjusted size */
        border-radius: 50%;
        border: none;
        background-color: #ffffff;
        box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.3);
        cursor: pointer;
        margin-top: 10px;  /* Increased margin for more space between buttons */
        transition: transform 0.3s ease-in-out;
        overflow: hidden;
    }

    .sub-buttons button img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover; /* Make image cover the button */
    }

    /* Custom colors for sub-buttons */
    .sub-buttons button.passwall2 {
        background-color: #29562e;
    }

    .sub-buttons button.reboot {
        background-color: #f55454;
    }

    .sub-buttons button.telegram {
        background-color: #00adec;
    }

    .sub-buttons button.dashboard {
        background-color: #29562e;
    }

    /* Animation for opening the buttons */
    .sub-buttons.open {
        bottom: 180px; /* Move 180px up when opened */
        transform: translateY(0);
    }
</style>

<div id="floating-button" onclick="toggleButtons()">
    <img src="/luci-static/argon/button/apple-touch-icon.png" alt="PeDitX Button">
</div>

<div class="sub-buttons" id="sub-buttons">
    <!-- Passwall2 Button -->
    <button class="passwall2" onclick="window.location.href='/cgi-bin/luci/admin/services/passwall2'">
        <img src="/luci-static/argon/button/passwall2.png" alt="Passwall2 Button">
    </button>
    <!-- Dashboard Button -->
    <button class="dashboard" onclick="window.location.href='/cgi-bin/luci/admin/status/overview'">
        <img src="/luci-static/argon/button/rm.png" alt="Dashboard Button">
    </button>
    <!-- Reboot Button -->
    <button class="reboot" onclick="window.location.href='/cgi-bin/luci/admin/system/reboot'">
        <img src="/luci-static/argon/button/reboot.png" alt="Reboot Button">
    </button>
    <!-- Telegram Button -->
    <button class="telegram" onclick="window.open('https://t.me/peditx', '_blank')">
        <img src="/luci-static/argon/button/tl.png" alt="Telegram Button">
    </button>
</div>

<script>
    function toggleButtons() {
        var subButtons = document.getElementById('sub-buttons');
        subButtons.classList.toggle('open');
    }
</script>
EOF

# Restart uhttpd to apply changes
/etc/init.d/uhttpd restart

clear

echo "PeDitX button with sub-buttons added successfully. Please refresh LuCI to view the changes."
sleep 2
############

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

if [ -f "$favicon_path" ]; then
    echo -e "${GREEN}Favicon replaced successfully ✅ OK${NC}"
else
    echo -e "${RED}Favicon replacement failed ❌ FAILED${NC}"
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
echo -e "${GREEN} 8.${NC} ${CYAN} Uninstall all Tools ${NC}"
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
        
echo "Uninstall tools ..."

curl -ksSL https://raw.githubusercontent.com/peditx/iranIPS/refs/heads/main/.files/core/uninstall.sh -o uninstall.sh && bash uninstall.sh
 
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
