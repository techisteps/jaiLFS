> [!CAUTION]  
<font color="#FF0000"><b> Act as ROOT </b></font> and verify environment using ```env-check.sh```
---

https://www.linuxfromscratch.org/lfs/view/stable/chapter04/creatingminlayout.html  
4.2. Creating a Limited Directory Layout in the LFS Filesystem  

```bash
# Minimum required directories creation
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

```



https://www.linuxfromscratch.org/lfs/view/stable/chapter04/addinguser.html  
4.3. Adding the LFS User  

```bash
# Create lfs user/group
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# Set password for lfs (generally same as user)
passwd lfs

# Make lfs user owner
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

su - lfs

```

