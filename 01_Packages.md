>> ### Act as ROOT and verify check_vars.sh

https://www.linuxfromscratch.org/lfs/view/stable/chapter03/introduction.html  
3.1. Introduction  

```bash
# Create directory to hold sources
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

# Download all packages and patches (all links are present in file "wget-list-sysv")
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources

# Copy md5 hashs for next step
cp md5sums $LFS/sources/

# Check sanctity
pushd $LFS/sources
  md5sum -c md5sums
popd

# Update ownership
chown root:root $LFS/sources/*
```
