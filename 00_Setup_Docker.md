>> ### Act as ROOT and verify check_vars.sh

## Setup host envinronment for LFS build

### Create host system
```powershell
#docker run --privileged -itd -h lfshost --name LFS -v$(pwd):/var/mountdisk ubuntu
docker run --privileged -itd -h lfshost --name LFS -v .:/mnt/hostfs ubuntu:24.04

# Run below command if container is running, else start it with subsequent command and attach again.
docker attach LFS

# Only run if container is in stop state
docker start LFS
```

### Install mimimum required and expected packages
https://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html  
2.2. Host System Requirements  
```bash
# Run below commands to install minimun packages required on host system for LFS build
apt update
apt install build-essential
apt install binutils coreutils diffutils findutils
apt install bison gawk m4 python3 texinfo vim nano wget
apt install flex expect dejagnu llvm libisl23
apt install gettext

# version-check.sh script expect shell to be bash
ln -fs /usr/bin/bash /bin/sh
ln -fs /usr/bin/bash /usr/bin/sh
ln -fs /usr/bin/gawk /usr/bin/awk
ln -fs /usr/bin/bison /usr/bin/yacc

# check required versions
cd /mnt/hostfs
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
# Create disk image and format as ext4 filesystem
cd /mnt/hostfs/ && truncate -s 10G boot.img
cd /mnt/hostfs/ && mkfs.ext4 boot.img

# Remember hardcoing of LFS
# Below is the location where created disk will be mounted
export LFS=/mnt/lfs
echo $LFS
# set LFS variable in .bashrc and .bash_profile so its always available
echo "export LFS=/mnt/lfs" >> ~/.bashrc
echo "export LFS=/mnt/lfs" >> ~/.bash_profile

mkdir -pv $LFS
# Below both commands will provide same result, run and check lsblk
#mount boot.img /mnt/lfs
cd /mnt/hostfs/ && mount -v -t ext4 boot.img $LFS

```

```bash
# TEST 
lsblk               # To check that files mounted to given location as loop device
mount | grep lfs    # To check that nosuid or nodev options are not present
```

Verify that output of above command shows as below. (rw,relatime) should not contain nosuid or nodev etc.
```
### /mnt/hostfs/boot.img on /mnt/lfs type ext4 (rw,relatime)
```

## Below check should be performed everytime you login

```bash
/mnt/hostfs/check_vars.sh
# or
cd /mnt/hostfs/ && ./check_vars.sh
```


```bash
echo $LFS           # Should be /mnt/lfs
lsblk               # To check that files mounted to given location as loop device
mount | grep lfs    # To check that nosuid or nodev options are not present
whoami              # Should be root on host
echo $0             # Should be bash

ls -lrt /usr/bin/sh         # Should be symbolic link to "/usr/bin/bash" if its not than run as root "ln -fs /usr/bin/bash /usr/bin/sh"
ls -lrt /usr/bin/awk        # Should be symbolic link to "/usr/bin/gawk" if its not than run as root "ln -fs /usr/bin/gawk /usr/bin/awk"
ls -lrt /usr/bin/yacc       # Should be symbolic link to "/usr/bin/bison" if its not than run as root "ln -fs /usr/bin/bison /usr/bin/yacc"

```