#!/bin/bash

Green='\033[0;32m'          # Green
Red='\033[0;31m'            # Red
NC='\033[0m'                # No Color


clear
echo 
echo "- ENV Vars --"

if [ "$LFS" == "/mnt/lfs" ]; then echo -e "LFS is ${LFS} ${Green} PASS ${NC}"; else echo -e "LFS is ${LFS} ${Red} FAIL ${NC}"; fi
if [ `whoami` == "root" ]; then echo -e "User is `whoami` ${Green} PASS ${NC}"; else echo -e "User is `whoami` ${Red} FAIL ${NC}"; fi

echo "-------------"


echo 
echo "- Shell -----"

ANS=`echo $SHELL | grep bash`
if [ $? == 0 ]; then echo -e "Shell is ${ANS} ${Green} PASS ${NC}"; else echo -e "Shell is ${SHELL} ${Red} FAIL ${NC}"; fi

echo "-------------"


echo 
echo "- Mounts ----"
# mount | awk '{if ($3 == "/mnt/HostFS") { exit 0}} ENDFILE{exit -1}'
# mountpoint /mnt/HostFS/
# findmnt /mnt/HostFS/
# cat /proc/mounts

ANS=`mountpoint -q $HostFS`;
if [ $? == 0 ]; then echo -e "mount ${HostFS} ${Green} PASS ${NC}"; else echo -e "mount ${HostFS} ${Red} FAIL ${NC}"; fi

ANS=`mountpoint -q $LFS`;
if [ $? == 0 ]; then echo -e "mount ${LFS} ${Green} PASS ${NC}"; else echo -e "mount ${LFS} ${Red} FAIL ${NC}"; fi

echo "-------------"


echo 
echo "- Aliases ---"

ANS=`readlink -f /usr/bin/sh | grep bash`
if [ $? == 0 ]; then echo -e "sh -> ${ANS} ${Green} PASS ${NC}"; else echo -e "sh -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/awk | grep gawk`
if [ $? == 0 ]; then echo -e "awk -> ${ANS} ${Green} PASS ${NC}"; else echo -e "awk -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/yacc | grep bison`
if [ $? == 0 ]; then echo -e "yacc -> ${ANS} ${Green} PASS ${NC}"; else echo -e "yacc -> ${ANS} ${Red} FAIL ${NC}"; fi

echo "-------------"

