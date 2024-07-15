> [!CAUTION]  
<font color="#FF0000"><b> Act as ROOT </b></font> and verify environment using ```env-check.sh```
---

## Setup host environment for LFS build

### Create host system
```powershell
#docker run --privileged -itd -h lfshost --name LFS -v$(pwd):/var/mountdisk ubuntu
docker run --privileged -itd -h lfshost --name LFS -v .:/mnt/HostFS ubuntu:24.04

# Run below command if container is running, else start it with subsequent command and attach again.
docker attach LFS

# Only run if container is in stop state
docker start LFS
```

### Install minimum required and expected packages
https://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html  
2.2. Host System Requirements  
```bash
# Run below commands to install minimun packages required on host system for LFS build
apt update
apt install build-essential
apt install binutils coreutils diffutils findutils util-linux xz-utils util-linux
apt install bison gawk m4 python3 texinfo vim nano wget
apt install flex expect dejagnu llvm libisl23
apt install gettext bash bc file grep gzip man-db procps psmisc sed tar perl
apt install zlib1g libncurses6 libncursesw6 

# version-check.sh script expect shell to be bash
ln -fs /usr/bin/bash /bin/sh
ln -fs /usr/bin/bash /usr/bin/sh
ln -fs /usr/bin/gawk /usr/bin/awk
ln -fs /usr/bin/bison /usr/bin/yacc

# check required versions
cd /mnt/HostFS
bash version-check.sh
```

### Create host system

https://www.linuxfromscratch.org/lfs/view/stable/chapter02/creatingfilesystem.html  
2.5. Creating a File System on the Partition  
>( Reference for similar activity: https://youtu.be/guSDz5Iwgw0?t=810 )

https://www.linuxfromscratch.org/lfs/view/stable/chapter02/aboutlfs.html  
2.6. Setting The $LFS Variable  

https://www.linuxfromscratch.org/lfs/view/stable/chapter02/mounting.html  
2.7. Mounting the New Partition  

```bash
# Remember hardcoding of LFS
# Below is the location where created disk will be mounted
export LFS=/mnt/lfs
echo $LFS
export HostFS=/mnt/HostFS
echo $HostFS
export LFS_Disk_Name=lfsDisk.img
echo $LFS_Disk_Name

# set LFS and HostFS variable in .bashrc so its always available
echo "export LFS=/mnt/lfs" >> ~/.bashrc
echo "export HostFS=/mnt/HostFS" >> ~/.bashrc
echo "export LFS_Disk_Name=lfsDisk.img" >> ~/.bashrc
echo "export MAKEFLAGS=-j$(nproc)" >> ~/.bashrc

# Create disk image and format as ext4 filesystem
cd $HostFS && truncate -s 10G $LFS_Disk_Name
cd $HostFS && mkfs.ext4 $LFS_Disk_Name

mkdir -pv $LFS
# Below both commands will provide same result, run and check lsblk
#mount $LFS_Disk_Name /mnt/lfs
cd $HostFS && mount -v -t ext4 $LFS_Disk_Name $LFS

```

```bash
# TEST 
lsblk               # To check that files mounted to given location as loop device
mount | grep lfs    # To check that nosuid or nodev options are not present
```

Verify that output of above command shows as below. (rw,relatime) should not contain nosuid or nodev etc.
```
### /mnt/hostfs/$LFS_Disk_Name on /mnt/lfs type ext4 (rw,relatime)
```

## Below check should be performed everytime you login

```bash
$HostFS/env-check.sh
# or
cd $HostFS && ./env-check.sh
```


```bash
# echo $LFS           # Should be /mnt/lfs
# lsblk               # To check that files mounted to given location as loop device
# mount | grep lfs    # To check that nosuid or nodev options are not present
# whoami              # Should be root on host
# echo $0             # Should be bash
# 
# # ls -lrt /usr/bin/sh         # Should be symbolic link to "/usr/bin/bash" if its not than run as root "ln -fs /usr/bin/bash /usr/bin/sh"
# # ls -lrt /usr/bin/awk        # Should be symbolic link to "/usr/bin/gawk" if its not than run as root "ln -fs /usr/bin/gawk /usr/bin/awk"
# # ls -lrt /usr/bin/yacc       # Should be symbolic link to "/usr/bin/bison" if its not than run as root "ln -fs /usr/bin/bison /usr/bin/yacc"

```