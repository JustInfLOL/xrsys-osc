@echo off
chcp 936 > nul
cd /d "%~dp0"
title ����ָ�
if exist "%SystemDrive%\Windows\Setup\xrsysnotheme.txt" (
    exit
)
if exist "%SystemDrive%\Windows\Setup\xrsyswall.jpg" (
    move /y "%SystemDrive%\Setup\xrsyswall.jpg" wallpaper.jpg
)
if exist "%SystemDrive%\Windows\Setup\zjsoftseewo.txt" call :iwb
if exist "%SystemDrive%\Windows\Setup\zjsofthite.txt" call :iwb
if exist "%SystemDrive%\Windows\Setup\zjsoftwenxiang.txt" (
    regedit /s touchwx.reg
    call :iwb
)
::ϵͳ�汾�ж�
set osver=0
::����һ�пɸ���ϵͳ����ֶ���дϵͳ�汾����������ȫ��ע�͵�
ver | find /i "5.1." > nul && set osver=1
ver | find /i "6.0." > nul && set osver=2
ver | find /i "6.1." > nul && set osver=2
ver | find /i "6.2." > nul && set osver=3
ver | find /i "6.3." > nul && set osver=3
ver | find /i "6.4." > nul && set osver=4
ver | find /i "10.0." > nul && set osver=4

:main
if exist "%SystemDrive%\Windows\Resources\Themes\Light.theme" (
    start "" "%SystemDrive%\Windows\Resources\Themes\Light.theme"
) else if exist "%SystemDrive%\Windows\Resources\Themes\aero.theme" (
    start "" "%SystemDrive%\Windows\Resources\Themes\aero.theme"
)
timeout -t 3 2>nul || ping 127.0.0.1 -n 3 >nul
taskkill /F /IM SystemSettings.exe
if %osver% GEQ 2 %PECMD% TEAM FIND --class:CabinetWClass --wid* R^|KILL @@%%R%% 
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Themes\Custom.theme"
goto setwall

:setwall
cd /d "%~dp0"
timeout /t 5
if exist wallpaper.jpg (
    copy /y wallpaper.jpg "%SystemDrive%\Windows\Version.jpg"
    %PECMD% WALL "%SystemDrive%\Windows\Version.jpg"
    if %osver% GEQ 2 (
        reg add "hkcu\control panel\desktop" /f /v "wallpaper" /d "%SystemDrive%\Windows\Version.jpg"
        reg add "hkcu\control panel\desktop" /f /v "WallpaperStyle" /d "10"
        RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
    )
)
reg delete "HKCU\Control Panel\Desktop" /f /v "Wallpaper.PECMD"
exit

:iwb
if exist "%ProgramW6432%" (
    PinToTaskbar.exe /pin "%SystemDrive%\Windows\System32\osk.exe"
) else (
    %PECMD% PINT "%SystemDrive%\Windows\System32\osk.exe",TaskBand
)
regedit /s touch.reg
goto :EOF