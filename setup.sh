#!/usr/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

user=root

if [[ $1 ]] ; then
  user=$1
fi
echo "Installing for user $user..."

# set up folders
echo "Making folders..."
mkdir -p "/home/$user/.config/"
mkdir -p "/home/$user/.config/fish/"
mkdir -p "/home/$user/.config/ftc"

# copy files
echo "Copying files..."
cp ./starship.toml "/home/$user/.config/starship.toml"
cp ./config.fish  "/home/$user/.config/fish/config.fish"
cp ./ftc.fish  "/home/$user/.config/ftc/ftc.fish"

# install
echo "Installing packages..."
apt update
apt install fish neofetch fzf -y
snap install starship

# set default shell
echo "Changing defautl shell..."
usermod --shell /bin/fish "$user"

echo "Done! Restart ssh or log out then log into account to see changes"
