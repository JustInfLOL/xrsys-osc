@echo off
chcp 936 > nul
title �����ܲò���ж��
rem ���������ܲý���
taskkill /im DrvCeo.exe /f /t
taskkill /im DrvCeox86.exe /f /t
taskkill /im DrvCeox64.exe /f /t

rem ɾ�������ܲÿ�ݷ�ʽ
for /f "tokens=3,*" %%i in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Common Desktop"') do (set desk=%%j)
for /f "tokens=3,*" %%i in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Common Programs"') do (set pro=%%j)
del /q /f "%desk%\�����ܲ�.lnk"
del /q /f "%desk%\�ӿ���.lnk"
del /q /f "%desk%\DrvCeo.lnk"
rd /s /q "%pro%\�����ܲ�"
rd /s /q "%pro%\�ӿ���"
rd /s /q "%pro%\DrvCeo"
del /q /f "%pro%\..\�����d.lnk"
del /q /f "%pro%\..\��������.lnk"
rd /s /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�2.0"
rd /s /q "%systemdrive%\Program Files (x86)\SysCeo"
rd /s /q "%systemdrive%\Program Files\SysCeo"
del /f /q "%systemdrive%\Users\Public\Desktop\�����ܲ�.lnk"
rem ɾ�������ܲ�ע���Ϳ������ж����Ϣ
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo  /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo  /f
Reg Delete "HKLM\SOFTWARE\SysCeo" /f
Reg Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo2.0" /f
Reg Delete "HKLM\SOFTWARE\SOFTWARE\Wow6432Node\SysCeo" /f
Reg Delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo2.0" /f
echo HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DcProtect  [1 7 17] >"%~dp0reg.ini"
regini.exe "%~dp0reg.ini"
del /f /q "%~dp0reg.ini"

REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC" /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo2.0\   /f
reg delete HKEY_LOCAL_MACHINE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo2.0\   /f
reg delete HKEY_LOCAL_MACHINE\SysCeo\DrvCeo\   /f
reg delete HKEY_LOCAL_MACHINE\Wow6432Node\SysCeo\DrvCeo\   /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DrvCeo\   /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\ /v DrvCeo   /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run\DrvCeo /v DrvCeo   /f
reg delete HKEY_LOCAL_MACHINE\system\ControlSet001\Services\DcProtect\   /f


rem ɾ�������ܲ�������
attrib.exe -s -h "%systemdrive%\Program Files\SysCeo\Drvceo\Drvceo.exe" /S /D 
attrib.exe -s -h "%systemdrive%\Program Files\SysCeo\Drvceo\" /S /D 
attrib.exe -s -h "%systemdrive%\Program Files\SysCeo\" /S /D 
attrib.exe -s -h "%systemdrive%\Program Files (x86)\SysCeo\Drvceo\Drvceo.exe" /S /D 
attrib.exe -s -h "%systemdrive%\Program Files (x86)\SysCeo\Drvceo\" /S /D 
attrib.exe -s -h "%systemdrive%\Program Files (x86)\SysCeo\" /S /D 
attrib.exe -s -h "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�2.0\�����ܲ�.LNK" /S /D 
attrib.exe -s -h "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�2.0\" /S /D 
attrib.exe -s -h "%systemdrive%\Users\Public\Desktop\�����ܲ�.LNK" /S /D 
attrib.exe -s -h "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�" /S /D 
attrib.exe -s -h "%ALLUSERSPROFILE%\����ʼ���˵�\����\�����ܲ�" /S /D 
attrib.exe -s -h "%systemroot%%\Help\dcold.exe"
del /q /f "%systemroot%%\Help\dcold.exe"
del /f /q "%systemdrive%\Program Files\SysCeo\Drvceo\Drvceo.exe"
del /f /q "%systemdrive%\Users\Public\Desktop\�����ܲ�.LNK"
del /f /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�2.0\�����ܲ�.LNK"
del /f /q "%systemdrive%\Program Files\SysCeo\Drvceo\Drvceo.exe" 
del /f /q "%WinDir%\System32\drivers\DcProtect_10x64.sys" 
del /f /q "%WinDir%\System32\drivers\DcProtect_10x86.sys" 
del /f /q "%WinDir%\System32\drivers\DcProtect_7x64.sys" 
del /f /q "%WinDir%\System32\drivers\DcProtect_7x86.sys" 
RD "%systemdrive%\Program Files\SysCeo\Drvceo\"  /Q /S 
RD "%systemdrive%\Program Files\SysCeo\"  /Q /S 
RD "%systemdrive%\Program Files (x86)\SysCeo\Drvceo\"  /Q /S 
RD "%systemdrive%\Program Files (x86)\SysCeo\"  /Q /S 
RD "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�"  /Q /S 
RD "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�2.0"  /Q /S 
rd /s /q "%ALLUSERSPROFILE%\����ʼ���˵�\����\�����ܲ�"
rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\�����ܲ�"

rem ɾ��������ѹĿ¼
Attrib -s -r -h "%SystemDrive%\DrvPath\*.*"
rd /s /q "%SystemDrive%\DrvPath"
exit