Set important environment variables
```bash
export LFS=/mnt/lfs
echo $LFS
export HostFS=/mnt/HostFS
echo $HostFS
```

Mount HostFS
```bash
mkdir -pv $HostFS
mount -t vboxsf HostFS $HostFS
```

Mount LFS
Set important environment variables
```bash
mkdir -pv $LFS
mount -v -t ext4 /dev/sdb1 $LFS
```

```bash
cp $HostFS/env-check.sh .

cp $HostFS/env-check.sh /usr/bin/

./env-check.sh

$HostFS/env-check.sh
```

```bash
cp $HostFS/version-check.sh .

./version-check.sh
```

