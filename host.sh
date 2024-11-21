#!/bin/sh

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Clear the terminal
clear

# Display the banner
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
                                      
                       Github/Sourceforge/OpenWrt Addresses Fixer ${NC}"

# Main menu function
main_menu() {
  echo -e "${CYAN}Select an option:${NC}"
  echo -e "${YELLOW}1- host 1${NC}"
  echo -e "${YELLOW}2- host 2${NC}"
  echo -e "${YELLOW}3- host 3${NC}"
  echo -e "${YELLOW}4- host 4${NC}"
  echo -e "${YELLOW}5- Remove config${NC}"
  echo -e "${YELLOW}6- Run EZPasswall Script${NC}"
  echo -e "${RED}7- Exit${NC}"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      set_hosts "185.199.108.133"
      ;;
    2)
      set_hosts "185.199.109.133"
      ;;
    3)
      set_hosts "185.199.110.133"
      ;;
    4)
      set_hosts "185.199.111.133"
      ;;
    5)
      remove_config
      ;;
    6)
      echo -e "${BLUE}Run EZPasswall Script...${NC}"
      opkg update
      opkg install coreutils-base64 bash
      rm -f ezp.sh && wget -qO - https://raw.githubusercontent.com/peditx/EZpasswall/refs/heads/main/ezp.b64 | awk '{print $1}' | base64 -d > ezp.sh && chmod +x ezp.sh && sh ezp.sh

      ;;
    7)
      echo -e "${GREEN}Exiting...${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid choice. Try again.${NC}"
      main_menu
      ;;
  esac
}

set_hosts() {
  local ip="$1"
  echo -e "${YELLOW}Setting /etc/hosts for IP ${ip}...${NC}"
  rm -f /etc/hosts
  echo "$ip raw.githubusercontent.com" >> /etc/hosts
  echo "216.105.38.12 master.dl.sourceforge.net" >> /etc/hosts
  echo "151.101.2.132 downloads.openwrt.org" >> /etc/hosts
  echo -e "${GREEN}/etc/hosts has been updated.${NC}"
  main_menu
}

remove_config() {
  echo -e "${YELLOW}Removing /etc/hosts configuration...${NC}"
  rm -f /etc/hosts
  echo -e "${GREEN}Configuration removed.${NC}"
  main_menu
}

# Run the main menu
main_menu
