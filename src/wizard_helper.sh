#!/bin/bash
[[ $#  -lt 4 ]] && exit 1

CONFDIR=/usr/lib/sddm/sddm.conf.d
CONFFILE=80-lliurex.conf
USER=$1
PASS=$2
LANG=$3
HOSTNAME=$4
LOGIN=$5

function enable_sddm_autologin()
{
	WRKFILE=${CONFDIR}/${CONFFILE}
	sed -i "s/User=.*/User=$LOGIN/g" $WRKFILE 
}

function disable_sddm_autologin()
{
	WRKFILE=${CONFDIR}/${CONFFILE}
	sed -i "s/User=.*/User=/g" $WRKFILE 
}

function set_locale()
{
	printf "[Formats]\nLANG=$LANG\n" > /home/$USER/.config/plasma-localerc
	chown $USER:$USER /home/$USER/.config/plasma-localerc
}

function set_hostname()
{
	[ -z $HOSTNAME ] && HOSTNAME="LliuWin"
	hostnamectl set-hostname $HOSTNAME
	sed -i "s/lliurexStandardPC.*/$HOSTNAME/" /etc/hosts	
}

useradd -s /bin/bash -m -U -G adm,cdrom,sudo,dip,plugdev,lpadmin,sambashare $USER
echo "$USER:$PASS" | chpasswd
set_locale
set_hostname
[[ $LOGIN != "" ]] && enable_sddm_autologin || disable_sddm_autologin
