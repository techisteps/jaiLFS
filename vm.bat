@echo off
REM Change directory to VirtualBox installation folder
REM cd "C:\Program Files\Oracle\VirtualBox"

SET VMNAME=LFS
SET UUID=0d9fd495-b09e-4309-a348-88f7060cc84f
SET VMCMD="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
SET BOOTFILERAW="C:\Users\jaiku\projects\LFS\boot.img"
SET BOOTFILEVDI="C:\Users\jaiku\projects\LFS\boot.vdi"

SET action=%1
echo "Action submited" %action% 
echo "Valid actions are [1,0,b]"

REM exit 0

REM echo %action%
if %action%==0 %VMCMD% controlvm %VMNAME% poweroff
if %errorlevel% neq 0 (
    echo Failed to stop the VM
    pause
    exit /b %errorlevel%
)
if %action%==0 exit 0

if %action%==1 %VMCMD% startvm %VMNAME%
if %errorlevel% neq 0 (
    echo Failed to start the VM
    pause
    exit /b %errorlevel%
)
if %action%==1 exit 0

if not %action%==b exit 0


REM Detach existing storage medium
echo %VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --medium none
%VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --medium none
if %errorlevel% neq 0 (
    echo Failed to detach storage medium
    pause
    exit /b %errorlevel%
)

REM Remove existing VDI file
echo del %BOOTFILEVDI%
del %BOOTFILEVDI%
if %errorlevel% neq 0 (
    echo Failed to remove existing VDI file
    pause
    exit /b %errorlevel%
)


REM List HDDs (for reference)
REM %VMCMD% list hdds
%VMCMD% showmediuminfo disk boot.vdi

REM Convert raw disk image to VDI
echo %VMCMD% convertfromraw %BOOTFILERAW% %BOOTFILEVDI% --format VDI --uuid %UUID%
%VMCMD% convertfromraw %BOOTFILERAW% %BOOTFILEVDI% --format VDI --uuid %UUID%
if %errorlevel% neq 0 (
    echo Failed to convert raw disk image to VDI
    pause
    exit /b %errorlevel%
)

REM exit 0


REM Attach new VDI file to VM
echo %VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --type hdd --medium %BOOTFILEVDI%
%VMCMD% storageattach %VMNAME% --storagectl "SATA" --port 0 --device 0 --type hdd --medium %BOOTFILEVDI%
if %errorlevel% neq 0 (
    echo Failed to attach new VDI file
    pause
    exit /b %errorlevel%
)

echo All operations completed successfully.
pause



REM ```powershell
REM # cd "C:\Program Files\Oracle\VirtualBox"
REM 
REM # .\VBoxManage.exe convertfromraw "C:\Users\jaiku\projects\minilinux\minimal_linux\boot" "C:\Users\jaiku\projects\minilinux\minimal_linux\boot.vdi" --format VDI --uuid "0d9fd495-b09e-4309-a348-88f7060cc84f"
REM 
REM 
REM cd "C:\Program Files\Oracle\VirtualBox"
REM .\VBoxManage.exe storageattach LFS --storagectl "SATA" --port 0 --device 0 --medium none
REM rm "C:\Users\jaiku\projects\minilinux\minimal_linux\boot.vdi"
REM .\VBoxManage.exe list hdds # To get UUID for next command
REM .\VBoxManage.exe convertfromraw "C:\Users\jaiku\projects\minilinux\minimal_linux\boot" "C:\Users\jaiku\projects\minilinux\minimal_linux\boot.vdi" --format VDI --uuid 0d9fd495-b09e-4309-a348-88f7060cc84f
REM .\VBoxManage.exe storageattach LFS --storagectl "SATA" --port 0 --device 0 --type hdd --medium "C:\Users\jaiku\projects\minilinux\minimal_linux\boot.vdi"
REM 
REM ```
