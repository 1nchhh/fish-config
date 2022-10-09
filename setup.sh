#!/usr/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

user="root"

if [[ $1 ]] ; then
  user=$1
fi

basedir="/home/$user"

if [[  $user == "root" ]] ; then
basedir="/root"
else
basedir="/home/$user"
fi

echo "Installing for user $user in directory $basedir..."

# set up folders
echo "Making folders..."
mkdir -p "$basedir/.config/"
mkdir -p "$basedir/.config/fish/"
mkdir -p "$basedir/.config/ftc"

# copy files
echo "Copying files..."
cp ./starship.toml "$basedir/.config/starship.toml"
cp ./config.fish  "$basedir/.config/fish/config.fish"
cp ./ftc.fish  "$basedir/.config/ftc/ftc.fish"

# install
echo "Installing packages..."
apt update
apt install fish neofetch fzf -y
curl -fsSL https://starship.rs/install.sh | sh

# set default shell
echo "Changing defautl shell..."
usermod --shell /bin/fish "$user"

echo "Done! Restart ssh or log out then log into account to see changes"
