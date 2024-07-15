> [!CAUTION]  
<font color="#FF0000"><b> Act as ROOT </b></font> and verify environment using ```env-check.sh```
---

https://www.linuxfromscratch.org/lfs/view/stable/chapter07/changingowner.html  
7.2. Changing Ownership  

> **Test below before proceeding with compilation**

```bash

exit        # Make sure you exit from lfs user and work as root
whoami      # Make sure you work as root
echo $LFS   # Make sure LFS is set

chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/kernfs.html  
7.3. Preparing Virtual Kernel File Systems  

```bash

mkdir -pv $LFS/{dev,proc,sys,run}

mount -v --bind /dev $LFS/dev

mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/chroot.html  
7.4. Entering the Chroot Environment  

```bash

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login

```

https://www.linuxfromscratch.org/lfs/view/stable/chapter07/creatingdirs.html  
7.5. Creating Directories  

```bash

mkdir -pv /{boot,home,mnt,opt,srv}

mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/createfiles.html  
7.6. Creating Essential Files and Symlinks  

```bash

ln -sv /proc/self/mounts /etc/mtab

cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF

cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd
echo "tester:x:101:" >> /etc/group
install -o tester -d /home/tester

exec /usr/bin/bash --login

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/gettext.html  
7.7. Gettext-0.22.4  

```bash

cd /sources/
tar -xvf gettext-0.22.4.tar.xz
cd gettext-0.22.4


./configure --disable-shared

make

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin


cd /sources/
rm -rf gettext-0.22.4

```

https://www.linuxfromscratch.org/lfs/view/stable/chapter07/bison.html  
7.8. Bison-3.8.2  

```bash
cd /sources/
tar -xvf bison-3.8.2.tar.xz
cd bison-3.8.2


./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make

make install


cd /sources/
rm -rf bison-3.8.2

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/perl.html  
7.9. Perl-5.38.2  

```bash
cd /sources/
tar -xvf perl-5.38.2.tar.xz
cd perl-5.38.2


sh Configure -des                                        \
             -Dprefix=/usr                               \
             -Dvendorprefix=/usr                         \
             -Duseshrplib                                \
             -Dprivlib=/usr/lib/perl5/5.38/core_perl     \
             -Darchlib=/usr/lib/perl5/5.38/core_perl     \
             -Dsitelib=/usr/lib/perl5/5.38/site_perl     \
             -Dsitearch=/usr/lib/perl5/5.38/site_perl    \
             -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl \
             -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl

make

make install


cd /sources/
rm -rf perl-5.38.2

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/Python.html  
7.10. Python-3.12.2  

```bash
cd /sources/
tar -xvf Python-3.12.2.tar.xz
cd Python-3.12.2


./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make

make install


cd /sources/
rm -rf Python-3.12.2

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/texinfo.html  
7.11. Texinfo-7.1  

```bash
cd /sources/
tar -xvf texinfo-7.1.tar.xz
cd texinfo-7.1


./configure --prefix=/usr

make

make install


cd /sources/
rm -rf texinfo-7.1

```

https://www.linuxfromscratch.org/lfs/view/stable/chapter07/util-linux.html  
7.12. Util-linux-2.39.3  

```bash
cd /sources/
tar -xvf util-linux-2.39.3.tar.xz
cd util-linux-2.39.3


mkdir -pv /var/lib/hwclock

./configure --libdir=/usr/lib    \
            --runstatedir=/run   \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.39.3

make

make install


cd /sources/
rm -rf util-linux-2.39.3

```


https://www.linuxfromscratch.org/lfs/view/stable/chapter07/cleanup.html  
7.13. Cleaning up and Saving the Temporary System  

```bash

rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools

# Backup ##########
exit

mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}

cd $LFS
tar -cJpf $HOME/lfs-temp-tools-12.1.tar.xz .
###################

# Restore #########
cd $LFS
rm -rf ./*
tar -xpf $HOME/lfs-temp-tools-12.1.tar.xz
###################

```
