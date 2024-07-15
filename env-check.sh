#!/bin/bash

# Green='\033[0;32m'          # Green
# Red='\033[0;31m'            # Red
# NC='\033[0m'                # No Color

Green='\e[0;32m'            # Green
Red='\e[0;31m'              # Red
Blue='‘\e[1;34m'          # Blue
NC='\e[0m'                  # No Color

export LFS=/mnt/lfs
export HostFS=/mnt/HostFS

clear
echo 
echo "- ENV Vars --"

#if [ -z "$HostFS" ]; then echo "HostFS not set ${Red} FAIL ${NC}"; ERROR="1"; fi
#if [ -z "$LFS" ]; then echo "LFS not set ${Red} FAIL ${NC}"; ERROR="1"; fi
#if [ "$ERROR" == 1 ]; then exit 1; fi


if [ "$LFS" == "/mnt/lfs" ]; then echo -e "LFS is ${Blue} ${LFS} ${Green} PASS ${NC}"; else echo -e "LFS is ${Blue} ${LFS} ${Red} FAIL ${NC}"; fi
if [ "$HostFS" == "/mnt/HostFS" ]; then echo -e "HostFS is ${Blue} ${HostFS} ${Green} PASS ${NC}"; else echo -e "HostFS is ${Blue} ${HostFS} ${Red} FAIL ${NC}"; fi
if [ `whoami` == "root" ]; then echo -e "User is `whoami` ${Green} PASS ${NC}"; else echo -e "User is `whoami` ${Red} FAIL ${NC}"; fi

ANS=`echo $SHELL | grep bash`
if [ $? == 0 ]; then echo -e "Shell is ${ANS} ${Green} PASS ${NC}"; else echo -e "Shell is ${SHELL} ${Red} FAIL ${NC}"; fi

echo "-------------"

if [ "$ERROR" == 1 ]; then exit 1; fi

echo 
echo "- Aliases ---"

ANS=`readlink -f /usr/bin/sh | grep bash`
if [ $? == 0 ]; then echo -e "sh -> ${ANS} ${Green} PASS ${NC}"; else echo -e "sh -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/awk | grep gawk`
if [ $? == 0 ]; then echo -e "awk -> ${ANS} ${Green} PASS ${NC}"; else echo -e "awk -> ${ANS} ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/yacc | grep bison`
if [ $? == 0 ]; then echo -e "yacc -> ${ANS} ${Green} PASS ${NC}"; else echo -e "yacc -> ${ANS} ${Red} FAIL ${NC}"; fi

echo "-------------"

echo 
echo "- Mounts ----"
# mount | awk '{if ($3 == "/mnt/HostFS") { exit 0}} ENDFILE{exit -1}'
# mountpoint /mnt/HostFS/
# findmnt /mnt/HostFS/
# cat /proc/mounts

if [ -z "$LFS" ]; then 
    echo -e "LFS not set thus mount check is not performed ${Red} FAIL ${NC}"; ERROR="1"; 
else
    ANS=`mountpoint -q $LFS`;
    if [ $? == 0 ]; then echo -e "mount ${LFS} ${Green} PASS ${NC}"; else echo -e "mount ${LFS} ${Red} FAIL ${NC}"; fi
fi

if [ -z "$HostFS" ]; then 
    echo -e "HostFS not set thus mount check is not performed ${Red} FAIL ${NC}"; ERROR="1"; 
else
    ANS=`mountpoint -q $HostFS`;
    if [ $? == 0 ]; then echo -e "mount ${HostFS} ${Green} PASS ${NC}"; else echo -e "mount ${HostFS} ${Red} FAIL ${NC}"; fi
fi

# if [ -z "$HostFS" ]; then echo "HostFS not set thus mount check is not performed ${Red} FAIL ${NC}"; ERROR="1"; fi
# ANS=`mountpoint -q $LFS`;
# if [ $? == 0 ]; then echo -e "mount ${LFS} ${Green} PASS ${NC}"; else echo -e "mount ${LFS} ${Red} FAIL ${NC}"; fi

echo "-------------"