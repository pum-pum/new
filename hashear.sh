#!/bin/sh
red='\033[0;31m'
green='\033[0;32m'
echo
if [ -z "$2" ];then
	echo -e '256' $(sha256sum $1)
	echo -e 'md5' $(md5sum $1)
	echo -e '512' $(sha512sum $1)
else
	a=$(sha256sum "$1" | grep -w "$2") 
	if [ -z "$a" ]; then 
		printf "${red}no coincide con 256\\n"
	else
		printf "${green}coincide con 256\\n"
	fi
	b=$(md5sum "$1" | grep -w "$2")
	echo
	if [ -z "$b" ]; then
		printf "${red}no coincide con md5\\n"
	else
		printf "${green}coincide con md5\\n"
	fi
	c=$(sha512sum "$1" | grep -w "$2")
	echo
	if [ -z "$c" ]; then
		printf "${red}no coincide con 512\\n"
	else
		printf "${green}coincide con 512\\n"
	fi	
fi
echo

