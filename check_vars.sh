Green='\033[0;32m'          # Green
Red='\033[0;31m'            # Red
NC='\033[0m'                # No Color

clear
if [ "$LFS" == "/mnt/lfs" ]; then echo -e "LFS is ${LFS} ${Green} PASS ${NC}"; else echo -e "LFS is ${LFS} ${Red} FAIL ${NC}"; fi
if [ `whoami` == "root" ]; then echo -e "User is `whoami` ${Green} PASS ${NC}"; else echo -e "User is `whoami` ${Red} FAIL ${NC}"; fi
if [ $SHELL == "/bin/bash" ]; then echo -e "Shell is $SHELL ${Green} PASS ${NC}"; else echo -e "Shell is $SHELL ${Red} FAIL ${NC}"; fi

if [ $SHELL == "/bin/bash" ]; then echo -e "Shell is $SHELL ${Green} PASS ${NC}"; else echo -e "Shell is $SHELL ${Red} FAIL ${NC}"; fi
mount | grep lfs
if [ $? == 0 ]; then echo -e "mount | grep lfs ${Green} PASS ${NC}"; else echo -e "mount | grep lfs ${Red} FAIL ${NC}"; fi
# lsblk

# echo -e `ls -lrt /usr/bin/sh`
# ls -lrt /usr/bin/awk
# ls -lrt /usr/bin/yacc

ANS=`readlink -f /usr/bin/sh`
# echo $ANS
if [ $ANS == "/usr/bin/bash" ]; then echo -e "sh -> bash ${Green} PASS ${NC}"; else echo -e "sh -> bash ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/awk`
# echo $ANS
if [ $ANS == "/usr/bin/gawk" ]; then echo -e "awk -> gawk ${Green} PASS ${NC}"; else echo -e "awk -> gawk ${Red} FAIL ${NC}"; fi

ANS=`readlink -f /usr/bin/yacc`
# echo $ANS
if [ $ANS == "/usr/bin/bison" ]; then echo -e "yacc -> bison ${Green} PASS ${NC}"; else echo -e "yacc -> bison ${Red} FAIL ${NC}"; fi


