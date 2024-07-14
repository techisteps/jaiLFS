<font color="#FF0000"><b> Act as ROOT (in CHROOT) </b></font> and verify environment using ```env-check.sh```
---

https://www.linuxfromscratch.org/lfs/view/stable/chapter10/fstab.html  
10.2. Creating the /etc/fstab File  

```bash

cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point    type     options             dump  fsck
#                                                                order

/dev/sda       /              ext4     defaults            1     1
proc           /proc          proc     nosuid,noexec,nodev 0     0
sysfs          /sys           sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts       devpts   gid=5,mode=620      0     0
tmpfs          /run           tmpfs    defaults            0     0
devtmpfs       /dev           devtmpfs mode=0755,nosuid    0     0
tmpfs          /dev/shm       tmpfs    nosuid,nodev        0     0
cgroup2        /sys/fs/cgroup cgroup2  nosuid,noexec,nodev 0     0

# End /etc/fstab
EOF


```


https://www.linuxfromscratch.org/lfs/view/stable/chapter10/kernel.html  
10.3. Linux-6.7.4  

```bash
cd /sources/ && tar -xvf linux-6.7.4.tar.xz && cd linux-6.7.4


make mrproper

make menuconfig

# CHECKS #
grep WERROR .config # CONFIG_WERROR=y 
                    # Maybe this should not be set
grep PSI .config # CONFIG_PSI=y
grep PSI_DEFAULT_DISABLED .config # CONFIG_PSI_DEFAULT_DISABLED is not set
grep IKHEADERS .config # CONFIG_IKHEADERS is not set
grep CGROUPS .config # CONFIG_CGROUPS=y
grep MEMCG .config # CONFIG_MEMCG=y CONFIG_MEMCG_KMEM=y
grep EXPERT .config # CONFIG_RCU_EXPERT is not set 
                    # CONFIG_EXPERT is not set
grep RELOCATABLE .config # CONFIG_RELOCATABLE=y
grep RANDOMIZE_BASE .config # CONFIG_RANDOMIZE_BASE=y
grep STACKPROTECTOR .config # CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
                            #CONFIG_HAVE_STACKPROTECTOR=y
                            #CONFIG_STACKPROTECTOR=y
                            #CONFIG_STACKPROTECTOR_STRONG=y
grep UEVENT_HELPER .config # CONFIG_UEVENT_HELPER is not set
grep DEVTMPFS .config   # CONFIG_DEVTMPFS=y
                        # CONFIG_DEVTMPFS_MOUNT=y
                        # CONFIG_DEVTMPFS_SAFE is not set
grep DRM .config    # CONFIG_DRM=y
                    # CONFIG_DRM_FBDEV_EMULATION=y

grep FRAMEBUFFER_CONSOLE .config    # CONFIG_FRAMEBUFFER_CONSOLE=y
                                    # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
                                    # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
                                    # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set

grep X86_X2APIC .config # CONFIG_X86_X2APIC=y
grep PCI .config    # CONFIG_PCI=y
                    # CONFIG_PCI_MSI=y
grep IOMMU_SUPPORT .config  # CONFIG_IOMMU_SUPPORT=y
grep IRQ_REMAP .config  # CONFIG_IRQ_REMAP=y

##########


make

make modules_install

cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.7.4-lfs-12.1
cp -iv System.map /boot/System.map-6.7.4
cp -iv .config /boot/config-6.7.4
cp -r Documentation -T /usr/share/doc/linux-6.7.4


cd /sources/linux-6.7.4 && chown -R 0:0 .


install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF


#cd /sources/ && rm -rf linux-6.7.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter10/grub.html  
10.4. Using GRUB to Set Up the Boot Process  

```bash

# For rescue disk use "super_grub2_disk_hybrid_2.04s1.iso"

#grub-install loop3 # This command is not correct 
#grub-install /mnt/lfs # This command is not correct 


## Deviation from book ##

lsblk # Just to make sure that disk file is mounted 
# Make sure proper loop device mentioned in below command
grub-install --root-directory=/mnt/lfs --no-floppy --modules="part_msdos biosdisk" --force /dev/loop3 

cat > /mnt/lfs/boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
#set root=(hd0,2)

menuentry "GNU/Linux, Linux 6.7.4-lfs-12.1" {
        linux  /boot/vmlinuz-6.7.4-lfs-12.1 root=/dev/sda ro
}
EOF


# Powershell command
qemu-system-x86_64.exe -cdrom .\super_grub2_disk_hybrid_2.04s1.iso .\boot.img

passwd root
# Set root user password
# user: root
# pass: root

#########################


```


https://www.linuxfromscratch.org/lfs/view/stable/chapter11/theend.html  
11.1. The End  

```bash

echo 12.1 > /etc/lfs-release

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="12.1"
DISTRIB_CODENAME="jaiLFS"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="12.1"
ID=lfs
PRETTY_NAME="Linux From Scratch 12.1"
VERSION_CODENAME="jaiLFS"
HOME_URL="https://www.linuxfromscratch.org/lfs/"
EOF


```



https://www.linuxfromscratch.org/lfs/view/stable/chapter11/reboot.html  
11.3. Rebooting the System  

```bash

logout

umount -v $LFS/dev/pts
mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys

umount -v $LFS/home
umount -v $LFS

umount -v $LFS

```