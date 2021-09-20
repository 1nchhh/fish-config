#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

$user = "root"

if [[ $# -eq 1 ]] ; then
  $user = $1
fi

echo "Installing for user $user..."

# set up folders
echo "Making folders..."
mkdir -p ~/.config/
mkdir -p ~/.config/fish/
mkdir -p ~/.config/ftc

# copy files
echo "Copying files..."
cp ./starship.toml ~/.config/starship.toml
cp ./config.fish  ~/.config/fish/config.fish
cp ./ftc.fish  ~/.config/ftc/ftc.fish

# install
echo "Installing packages..."
apt update
apt install fish -y
snap install starship

# set default shell
echo "Changing defautl shell..."
usermod --shell /bin/fish "$user"

echo "Done! Restart ssh or log out then log into account to see changes"
