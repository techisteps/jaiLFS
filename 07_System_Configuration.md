<font color="#FF0000"><b> Act as ROOT (in CHROOT) </b></font> and verify environment using ```env-check.sh```
---

https://www.linuxfromscratch.org/lfs/view/stable/chapter09/bootscripts.html  
9.2. LFS-Bootscripts-20230728  

```bash
cd /sources/ && tar -xvf lfs-bootscripts-20230728.tar.xz && cd lfs-bootscripts-20230728


make install


cd /sources/ && rm -rf lfs-bootscripts-20230728
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter09/symlinks.html  
9.4. Managing Devices  

> Need to visit this chapter in detials again.  



https://www.linuxfromscratch.org/lfs/view/stable/chapter09/network.html  
9.5. General Network Configuration  

```bash

# REMEMBER Hardcoded IP's

cd /etc/sysconfig/
cat > ifconfig.enp0s3 << "EOF"
ONBOOT=yes
IFACE=enp0s3
SERVICE=ipv4-static
IP=192.168.1.112
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF


cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

domain jailfs.com
nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF


echo "jailfs" > /etc/hostname


cat > /etc/hosts << "EOF"
# Begin /etc/hosts

192.168.1.112 jailfs.com jailfs
127.0.0.1 jailfs.com jailfs
127.0.0.1 localhost.localdomain localhost
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
EOF

```



https://www.linuxfromscratch.org/lfs/view/stable/chapter09/usage.html  
9.6. System V Bootscript Usage and Configuration  

```bash

cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S06:once:/sbin/sulogin
s1:1:respawn:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF



cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF


cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

UNICODE="1"
FONT="Lat2-Terminus16"

# End /etc/sysconfig/console
EOF


#############################################################
# Refer (9.6.8. The rc.site File) and create file is you need
#############################################################

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter09/locale.html  
9.7. Configuring the System Locale  

```bash

cat > /etc/profile << "EOF"
# Begin /etc/profile

for i in $(locale); do
  unset ${i%=*}
done

if [[ "$TERM" = linux ]]; then
  export LANG=C.UTF-8
else
#  export LANG=<ll>_<CC>.<charmap><@modifiers>
  export LANG=en_US.ISO-8859-1@USD
fi

# End /etc/profile
EOF

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter09/inputrc.html  
9.8. Creating the /etc/inputrc File  

```bash
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

```

https://www.linuxfromscratch.org/lfs/view/stable/chapter09/etcshells.html  
9.9. Creating the /etc/shells File  

```bash
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

```
