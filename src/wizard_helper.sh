#!/bin/bash
[[ $#  -lt 4 ]] && exit 1

CONFDIR=/usr/lib/sddm/sddm.conf.d
CONFFILE=80-lliurex.conf
CONFDIR2=/etc/sddm.conf.d
CONFFILE2=kde_settings.conf
USER=$1
PASS=$2
LANG=$3
HOSTNAME=$4
LOGIN=$5

function enable_sddm_autologin()
{
	WRKFILE=${CONFDIR}/${CONFFILE}
	WRKFILE2=${CONFDIR2}/${CONFFILE2}
	sed -i "s/User=.*/User=$LOGIN/g" $WRKFILE 
	#Force X11 session
	sed -i "s/Session=.*/Session=plasma/g" $WRKFILE 
	if [ -e $WRKFILE2 ]
	then
		sed -i "s/User=.*/User=$LOGIN/g" $WRKFILE2
		#Force X11 session
		sed -i "s/Session=.*/Session=plasma/g" $WRKFILE2
	else
		mkdir $CONFDIR2 > /dev/null
		echo "[Autologin]" > $WRKFILE2
		echo "Relogin=false" >> $WRKFILE2
		echo "Session=plasma" >> $WRKFILE2
		echo "User=$LOGIN" >> $WRKFILE2
	fi
}

function disable_sddm_autologin()
{
	WRKFILE=${CONFDIR}/${CONFFILE}
	WRKFILE2=${CONFDIR2}/${CONFFILE2}
	sed -i "s/User=.*/User=/g" $WRKFILE 
	#Unset X11 
	sed -i "s/Session=.*/Session=/g" $WRKFILE 
	if [ -e $WRKFILE2 ]
	then
		sed -i "s/User=.*/User=/g" $WRKFILE2
		#Unset X11 
		sed -i "s/Session=.*/Session=/g" $WRKFILE2
	fi
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
rm /home/lliurex/.config/autostart/lliuwin-wizard.desktop 2>/dev/null
[[ $LOGIN != "" ]] && enable_sddm_autologin || disable_sddm_autologin
apt-get remove -y lliuwin-wizard 2>/dev/null
