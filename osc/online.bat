chcp 936 > nul
title OSConline
cd /d "%~dp0"
set url1=http://xr.66ccff.love/link
set url2=http://url.xrgzs.top
set url=%url1%
set rtc=0


if exist pack.7z (
    echo [OSC]���ڽ�ѹpack...>"%systemdrive%\Windows\Setup\wallname.txt"
    %zip% x -r -y -p123 pack.7z
    del /f /q pack.7z
    echo ok >unpacked.log
)

@rem ==========================================
@rem ����ȶ��ԣ�ǿ������������ʹ��osc�Դ�oscoffline
@rem goto offline
@rem ==========================================
if exist "%SystemDrive%\Windows\Setup\Set\zjsoftforceoffline.txt" goto offline
if exist "%SystemDrive%\Windows\Setup\zjsoftforceoffline.txt" goto offline
ping www.aliyun.com -4 -n 2 >nul
if %errorlevel% GEQ 1 goto offline
goto try

:try
%aria% -o checkconnect.txt "%url%/checkconnect"
type checkconnect.txt | find /i "isconnected" > nul && goto online
goto retry

:retry
if not "%rtc%"=="1" (
    set url=%url2%
    set rtc=1
    goto try
)
goto offline

:offline
if exist oscoffline.bat (
    copy /y oscoffline.bat osconline.bat
    goto online
)
if exist pack.bat (
    copy /y pack.bat osconline.bat
    goto online
)
goto local2

:online
cd /d "%~dp0"
if exist osconline.bat (
    call osconline.bat
) else (
    %aria% -o osconline.bat "%url%/osconline"
    if exist osconline.bat (
        call osconline.bat
    )
)
goto local2

:local2
if exist "%SystemDrive%\Windows\Setup\Run\2\api2.bat" (
    echo [OSC]����Ӧ��DIY�ӿ�api2.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /max /wait "%SystemDrive%\Windows\Setup\Run\2\api2.bat"
)
for %%b in (%SystemDrive%\Windows\Setup\Run\2\*.exe) do (
    echo [OSC]���ڰ�װԤװ���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%b" /S
    del /f /q "%%b"
)
for %%b in (%SystemDrive%\Windows\Setup\Run\2\*.msi) do (
    echo [OSC]���ڰ�װԤװ���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
    start "" /wait "%%b" /passive /qb-! /norestart
    del /f /q "%%b"
)
for %%b in (%SystemDrive%\Windows\Setup\Run\2\*.reg) do (
    echo [OSC]����Ӧ��ע���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
    regedit /s "%%b"
    del /f /q "%%b"
)

if exist "%SystemDrive%\Windows\Setup\xrsyssearchapi.txt" (
    for %%a in (C D E F G H) do (
        if exist "%%a:\Xiaoran\OSC\api2.bat" (
            echo [OSC]����Ӧ���ѵ���DIY�ӿ�%%a:\~\api2.bat...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /max /wait "%%a:\Xiaoran\OSC\api2.bat"
        )
        for %%b in (%%a:\Xiaoran\OSC\2\*.exe) do (
            echo [OSC]���������ѵ���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /S
            del /f /q "%%b"
        )
        for %%b in (%%a:\Xiaoran\OSC\2\*.msi) do (
            echo [OSC]���ڰ�װ�ѵ���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            start "" /wait "%%b" /passive /qb-! /norestart
            del /f /q "%%b"
        )
        for %%b in (%%a:\Xiaoran\OSC\2\*.reg) do (
            echo [OSC]����Ӧ���ѵ���%%b...>"%systemdrive%\Windows\Setup\wallname.txt"
            regedit /s "%%b"
            del /f /q "%%b"
        )
    )
)
goto end

:end
exit