@echo off
chcp 936 > nul
TITLE EOSNotify-����
CLS
ECHO.
SET winsxs=%SystemRoot%\winsxs
ECHO ����EOSNotify WinSXS...
FOR /f %%i IN ('dir /b %winsxs%\^|findstr ".*microsoft-windows-eosnotify.*"') DO (
takeown /a /r /d Y /f "%winsxs%\%%i" >NUL
icacls "%winsxs%\%%i" /T /C /grant administrators:D >NUL
ECHO ����ɾ��WinSXS
ECHO %%i
RMDIR /s /q "%winsxs%\%%i"
)
ECHO.
ECHO ɾ��EOSNotify ע���...
FOR /f %%i IN ('REG QUERY HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Winners^|findstr ".*microsoft-windows-eosnotify.*"') DO (
ECHO ����ɾ��ע���
reg delete %%i /f
)
ECHO.
ECHO ɾ��EOSNotify�ƻ�����...
schtasks /Change /DISABLE /TN "Microsoft\Windows\Setup\EOSNotify"
schtasks /Change /DISABLE /TN "Microsoft\Windows\Setup\EOSNotify2"
schtasks /delete /tn "\Microsoft\Windows\Setup\EOSNotify" /f
schtasks /delete /tn "\Microsoft\Windows\Setup\EOSNotify2" /f
IF EXIST "%SystemRoot%\System32\EOSNotify.exe" (
ECHO.
ECHO ɾ�� EOSNotify.exe �ļ�...
taskkill /F /IM "%SystemRoot%\System32\EOSNotify.exe" 1>NUL 2>NUL
takeown /a /f "%SystemRoot%\System32\EOSNotify.exe" >NUL
icacls "%SystemRoot%\System32\EOSNotify.exe" /grant administrators:D >NUL
DEL /F /S /Q "%SystemRoot%\System32\EOSNotify.exe"
)
IF EXIST "%SystemRoot%\Migration\WTR\EOSNotifyMig.inf" (
ECHO.
ECHO ɾ�� EOSNotifyMig.inf �ļ�...
DEL /F /S /Q "%SystemRoot%\Migration\WTR\EOSNotifyMig.inf"
)
ECHO.
ECHO �Ż�EOSNotify ע�������...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SipNotify" /v "DontRemindMe" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EOSNOTIFY.EXE" /v "Debugger" /t REG_SZ /d "*" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SIPNOTIFY.EXE" /v "Debugger" /t REG_SZ /d "*" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "Discontinue" /t REG_DWORD /d "1" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "LastRunTimestamp" /f
TIMEOUT 3 >NUL
ECHO.
exit
