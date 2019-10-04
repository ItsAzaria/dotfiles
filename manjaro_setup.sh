#!/usr/bin/env bash

read -r -p "This will setup the manjaro environment. Continue? [y/n] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]
then
	# Update packages
	sudo pacman -Syuu
	
	# Install yay
	sudo pacman -S yay --noconfirm
	
	packages=()
	
	# Essential
	packages+=('vivaldi bitwarden-bin protonvpn-cli sharenix-git megasync insync qbittorrent')
	
	# Music
	packages+=('spotify-dev spotify-adblock-git')
	
	# Media
	packages+=('dontpanic-latest popcorntime-bin kodi cpod-bin freetube-bin')
	
	# Social
	packages+=('discord-canary')
	
	# Games
	packages+=('lutris multimc5')
	
	# Editors
	packages+=('code')
	
	# Tools
	packages+=('postman-bin npm masterpdfeditor-free')
	
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
	PKGEXT=.pkg.tar yay -S $packageList --noconfirm
	
	systemctl start docker.service
	systemctl enable docker.service
	
	# Get spacemacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

	sudo groupadd docker
	sudo usermod -aG docker $USER
	
	# Prompt for reboot
	read -r -p "Install completed, reboot? [y/n] " response
	response=${response,,}
	if [[ "$response" =~ ^(yes|y)$ ]]
	then
		reboot
	else
		echo "All done."
	fi
else
	echo "Run again when you're ready to setup the manjaro environment"
fi


