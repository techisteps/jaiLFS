## Virtualbox Setup

Create new VM with:
1. Name "Alpine"
2. 10G Ram "10240 MB"
3. 8 Processor with "100%" execution cap
4. Video Memory 128 MB and 3D Acceleration
5. Attached ISO "alpine-standard-3.19.1-x86_64.iso"
6. Attached VDI images  
   a. One with 4GB capacity (This is for Alpine install)  
   b. Another with 16GB capacity (This is for LFS install)  
7. Network change to "Bridged Adapter"
8. Add a Shared Folder  
   a. Folder Path point to you project path  
   b. Folder Name "HostFS"  
   c. Mount Point "/mnt/HostFS"  
   d. Read Only FALSE  
   e. Auto-mount TRUE  
   f. Make Permanent TRUE  


## Install Alpine

Boot the VM and login as `root` user 
> [!IMPORTANT] 
> (No password required for root until you set one)

Once login run command ```setup-alpine```
```bash
setup-alpine
```
Answer all the questions.

- keymap: us  
- Variant: us  
- HostName: alpinehost  
- Interface: [select all defaults]  
- Root Password: root  
- Timezone: (Select Yours)  
- Proxy: None  
- APK Mirror:  
1 . Select c for enabling community repo  
2 . Select f to set fastest repo for your location  
- User: setup a user "alpine"  
- Disk and Install: select available disk in this case "sda" as usage "sys".  

Once installation complete run reboot
```bash
reboot
```

Few important links for reference:

> https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html  
> https://pkgs.alpinelinux.org/packages  
> https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts#  


## Alpine Host Setup

> [!TIP] 
> Putty will be helpful.
<!-- <font color="#F9F871"> Putty will be helpful. </font>   -->
### Steps to setup Putty

Check below on VBOX.
```bash
# Check networking services are running
rc-service networking status
# start if not running 
rc-service networking start
# Check IP address to connect
ip a s | grep inet
```

On Putty use IP received from above and use `alpine` (non-root) user to login. `root` user login will not work. Once login you can switch to `root` user by:
```bash
su -
#root password"
```

### Steps to install required packages

Login as `root` and run below commands to install required package for LSB requirement  
(https://www.linuxfromscratch.org/lfs/view/stable/prologue/standards.html)


```bash
apk update
apk add coreutils diffutils findutils binutils build-base util-linux
apk add bash grep bison gawk m4 sed texinfo xz shadow
apk add bc file gzip man-db ncurses procps psmisc tar zlib
apk add perl python3
apk add virtualbox-guest-additions
```

### Setup environment variables
```bash
export LFS=/mnt/lfs
echo $LFS
export HostFS=/mnt/HostFS
echo $HostFS

cat >> ~/.bashrc << "EOF"
export LFS=/mnt/lfs
export HostFS=/mnt/HostFS
export MAKEFLAGS=-j$(nproc)
EOF
cp ~/.bashrc ~/.bash_profile

source ~/.bash_profile
```

### Setup default shell
```bash
# Change default shell for alpine and root
chsh root #/bin/bash
chsh alpine #/bin/bash

# Exit the shell and login again
```

### Setup HostFS (Based on shared folder defined in VBOX)

```bash
# Check virtualbox-guest-additions is running
rc-service virtualbox-guest-additions status
# start if not running 
rc-service virtualbox-guest-additions start

# create mount point and mount
mkdir -pv $HostFS
mount -t vboxsf HostFS $HostFS
```

> [!CAUTION] 
> Must check environment before proceeding  

```bash
cp $HostFS/env-check.sh .
cp $HostFS/env-check.sh /usr/bin/
./env-check.sh
```

> [!IMPORTANT] 
Run version check  
( https://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html )  

```bash
# Correct links before version check
ln -fs /bin/bash /bin/sh
ln -fs /bin/bash /usr/bin/sh
ln -fs /usr/bin/gawk /usr/bin/awk
ln -fs /usr/bin/bison /usr/bin/yacc

cp $HostFS/version-check.sh .
./version-check.sh
```

### Setup LFS disk  
https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingfilesystem.html

```bash
lsblk
fdisk /dev/sdb
```

After disk partition print partition details. Details should be matching to below.
```bash
# Command (m for help): p
# Disk /dev/sdb: 16 GiB, 17179869184 bytes, 33554432 sectors
# Disk model: VBOX HARDDISK
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: dos
# Disk identifier: 0x305ba370
# 
# Device     Boot Start      End  Sectors Size Id Type
# /dev/sdb1        2048 33554431 33552384  16G 83 Linux
```

```bash
# Format partition as ext4
mkfs.ext4 /dev/sdb1

# Create mount point and mount
mkdir -pv $LFS
mount -v -t ext4 /dev/sdb1 $LFS

```
