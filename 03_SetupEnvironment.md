>> ### Act as lfs and verify check_vars.sh

https://www.linuxfromscratch.org/lfs/view/stable/chapter04/settingenvironment.html  
4.4. Setting Up the Environment  

```bash

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF


# Remember hardcoing of LFS
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

### Below command run as ROOT ###
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
#################################


#make -j16
export MAKEFLAGS=-j16


cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF


source ~/.bash_profile


```
