@echo off
chcp 936 > nul
cd /d "%~dp0"
ver | find /i "5.0." && exit
ver | find /i "5.1." && exit
echo [OSC]����ʹ������Ż�ϵͳ...>"%systemdrive%\Windows\Setup\wallname.txt"
start "" "yr.exe" /OPTini=[Optimization]OSC.ini
timeout -t 30 2>nul || ping 127.0.0.1 -n 30 >nul

if exist "%SystemDrive%\Windows\Setup\xroknoad.txt" (
	exit
)
if exist "%SystemDrive%\Windows\Setup\zjsoftspoem.txt" (
	exit
)
if exist "%SystemDrive%\Windows\Setup\xrsysnotheme.txt" (
	exit
)
if exist "%SystemDrive%\Windows\Setup\xrsysnooem.txt" (
	exit
)
echo [OSC]����ʹ����ߵ���ϵͳOEM��Ϣ...>"%systemdrive%\Windows\Setup\wallname.txt"
copy /y yr.exe INPOEM.exe
regedit /s INPOEM.reg
start /wait INPOEM.exe /inpouringoem
regedit /s UNINPOEM.reg
exit