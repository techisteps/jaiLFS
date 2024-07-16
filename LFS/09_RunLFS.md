
# Option 1

```powershell
# Powershell command
qemu-system-x86_64.exe -cdrom .\super_grub2_disk_hybrid_2.04s1.iso .\boot.img
```


# Option 2

Create a VM on VirtualBox named LFS and setup networking as bridge.

```powershell
SET VMNAME=LFS
SET UUID=0d9fd495-b09e-4309-a348-88f7060cc84f
SET VMCMD="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
SET BOOTFILERAW="C:\tmp\LFS\boot.img"
SET BOOTFILEVDI="C:\tmp\LFS\boot.vdi"

%VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --medium none
rm %BOOTFILEVDI%
%VMCMD% list hdds # To get UUID for next command
%VMCMD% convertfromraw %BOOTFILERAW% %BOOTFILEVDI% --format VDI --uuid %UUID%
%VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --type hdd --medium %BOOTFILEVDI%

```
