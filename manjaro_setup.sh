#!/usr/bin/sudo bash

read -r -p "This weill setup the manjaro environment. Continue? [y/n] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]
then
	echo "Updating packages"
	pacman -Syuu
	
	echo "Installing yay"
	pacman -S yay --noconfirm
	
	packages=()
	
	
	# Essential
	packages+=('vivaldi bitwarden-bin proton-cli sharenix-git megasync insync qbittorrent')
	
	# Music
	packages+=('spotify-dev spotify-adblock-git')
	
	# Media
	packages+=('dontpanic-latest popcorntime-bin kodi cpod freetube-bin')
	
	# Social
	packages+=('discord-canary')
	
	# Games
	packages+=('lutris multimc5')
	
	# Editors
	packages+=('code emacs')
	
	# Tools
	packages+=('postman npm masterpdfeditor-free')
	
	# Docker
	packages+=('docker lazydocker')
	
	# Android
	packages+=('android-studio flutter')
	
	# Other
	packages+=('neofetch tilix openshot obs-studio')
	
	# Fonts
	packages+=('nerd-fonts-roboto-mono')
	
	# Icons
	packages+=('flat-remix')
	
	# GTK theme
	packages+=('ant-dracula-gtk-theme')
	
	# Seperate package list with space delimiter
	packageList=$( IFS=$' '; echo "${packages[*]}" )
		
	#install packages, disable compression
	PKGEXT=.pkg.tar yay -S "$packageList" --noconfirm
	
	systemctl start docker
	systemctl enable docker
	
	# Get spacemacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	
	# Prompt for reboot
	read -r -p "Install completed, reboot? [y/n] " response
	response=${response,,}
	if [[ "$response" =~ ^(yes|y)$ ]]
	then
		reboot
	fi
else
	echo "Run again when you're ready to setup the manjaro environment"
fi


reboot
