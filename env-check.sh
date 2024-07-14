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
#if [ $SHELL == "/bin/bash" ]; then echo -e "Shell is $SHELL ${Green} PASS ${NC}"; else echo -e "Shell is $SHELL ${Red} FAIL ${NC}"; fi
if [ $? == 0 ]; then echo -e "Shell is ${ANS} ${Green} PASS ${NC}"; else echo -e "Shell is ${SHELL} ${Red} FAIL ${NC}"; fi
echo "-------------"

echo 
echo "- Mounts ----"
# mount | awk '{if ($3 == "/mnt/HostFS") { exit 0}} ENDFILE{exit -1}'
# mountpoint /mnt/HostFS/
# findmnt /mnt/HostFS/
# cat /proc/mounts
#ANS=`mount | grep HostFS`
#ANS=`mount | awk '{if ($3 == "/mnt/HostFS") { print $3; exit 0}} ENDFILE{ print $3; exit -1}'`;
ANS=`mountpoint -q $HostFS`;
if [ $? == 0 ]; then echo -e "mount ${HostFS} ${Green} PASS ${NC}"; else echo -e "mount ${HostFS} ${Red} FAIL ${NC}"; fi

#mount | grep lfs
#if [ $? == 0 ]; then echo -e "mount | grep lfs ${Green} PASS ${NC}"; else echo -e "mount | grep lfs ${Red} FAIL ${NC}"; fi
ANS=`mountpoint -q $LFS`;
if [ $? == 0 ]; then echo -e "mount ${LFS} ${Green} PASS ${NC}"; else echo -e "mount ${LFS} ${Red} FAIL ${NC}"; fi
# lsblk
echo "-------------"

# echo -e `ls -lrt /usr/bin/sh`
# ls -lrt /usr/bin/awk
# ls -lrt /usr/bin/yacc

echo 
echo "- Aliases ---"
ANS=`readlink -f /usr/bin/sh | grep bash`
# echo $ANS
#if [ $ANS == "/usr/bin/bash" ]; then echo -e "sh -> bash ${Green} PASS ${NC}"; else echo -e "sh -> bash ${Red} FAIL ${NC}"; fi
if [ $? == 0 ]; then echo -e "sh -> ${ANS} ${Green} PASS ${NC}"; else echo -e "sh -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/awk | grep gawk`
# echo $ANS
#if [ $ANS == "/usr/bin/gawk" ]; then echo -e "awk -> gawk ${Green} PASS ${NC}"; else echo -e "awk -> gawk ${Red} FAIL ${NC}"; fi
if [ $? == 0 ]; then echo -e "awk -> ${ANS} ${Green} PASS ${NC}"; else echo -e "awk -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/yacc | grep bison`
# echo $ANS
if [ $? == 0 ]; then echo -e "yacc -> ${ANS} ${Green} PASS ${NC}"; else echo -e "yacc -> ${ANS} ${Red} FAIL ${NC}"; fi
echo "-------------"

