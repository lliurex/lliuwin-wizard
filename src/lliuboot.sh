#/bin/bash

fix_efi()
{

EFIDRIVE=''
for i in $(lsblk | grep disk | cut -d " " -f1)
do 
	fdisk -l /dev/$i | grep EFI
	if [ $? -eq 0 ]
	then 
		EFIDRIVE=/dev/$i
		efibootmgr -c  -L "Windows Boot Manager" -l "\EFI\Boot\bootx64.efi" -d $EFIDRIVE
		break
	fi 
done

}

set_bootnext()
{
	ID=$(efibootmgr | grep -i windows | grep -o [0-9]*)
	[ ${#ID} -eq 4 ] && efibootmgr -n $ID
}

efibootmgr | grep -i "windows"
if [ $? -ne 0 ]
then
	fix_efi
fi	
set_bootnext
exit 0
