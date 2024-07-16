> [!CAUTION]  
<font color="#FF0000"><b> Act as ROOT (in CHROOT) </b></font> and verify environment using ```env-check.sh```
---

export LFS=/mnt/lfs
echo $LFS

export LFSBK=/mnt/lfsbk
echo $LFSBK

mount -v -t ext4 /dev/sdb1 $LFS


mkdir -pv /mnt/lfsbk/boot
mount -v -t ext4 /dev/sdc3 /mnt/lfsbk/
mount -v -t ext4 /dev/sdc1 /mnt/lfsbk/boot


rsync -a -p /mnt/lfs/ /mnt/lfsbk



rsync -a -p /mnt/lfs/boot/ /mnt/lfsbk/boot




mount -v --bind /dev $LFSBK/dev

mount -vt devpts devpts -o gid=5,mode=0620 $LFSBK/dev/pts
mount -vt proc proc $LFSBK/proc
mount -vt sysfs sysfs $LFSBK/sys
mount -vt tmpfs tmpfs $LFSBK/run

if [ -h $LFSBK/dev/shm ]; then
  install -v -d -m 1777 $LFSBK$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFSBK/dev/shm
fi


```
chroot "$LFSBK" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(LFSBK chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
```

You can run ```lsblk``` command and check TYPE. ```grun-install``` always points to **disk** and device in grub menu points to **part**.

Reference - https://superuser.com/questions/182161/grub-how-find-partition-number-hd0-x  

Grub and Linux method to point disk/partition
An example is: 
sda = hd0
sda1 = (hd0, 0)
sda2 = (hd0, 1)
sdb = hd1
sdb1 = (hd1, 0)
sdb2 = (hd1, 1)
sdc = hd2


```
alpinehost:~# lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0    4G  0 disk
├─sda1   8:1    0  300M  0 part /boot
├─sda2   8:2    0    1G  0 part [SWAP]
└─sda3   8:3    0  2.7G  0 part /
sdb      8:16   0   16G  0 disk
└─sdb1   8:17   0   16G  0 part /mnt/lfs
sr0     11:0    1 1024M  0 rom
```

```
grub-install /dev/sdc
```
```
linux   /boot/vmlinuz-6.7.4-lfs-12.1 root=/dev/sda3 ro
```

```
(LFSBK chroot) root:/# cat /etc/fstab
# Begin /etc/fstab

# file system  mount-point    type     options             dump  fsck
#                                                                order

/dev/sda3      /              ext4     defaults            1     1
#/dev/sda1      /boot          ext4     defaults            0     0
/dev/sda2      /swap          swap     pri=1               0     0
proc           /proc          proc     nosuid,noexec,nodev 0     0
sysfs          /sys           sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts       devpts   gid=5,mode=620      0     0
tmpfs          /run           tmpfs    defaults            0     0
devtmpfs       /dev           devtmpfs mode=0755,nosuid    0     0
tmpfs          /dev/shm       tmpfs    nosuid,nodev        0     0
cgroup2        /sys/fs/cgroup cgroup2  nosuid,noexec,nodev 0     0

# End /etc/fstab
```


