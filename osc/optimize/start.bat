chcp 936 > nul
cd /d "%~dp0"

:yr
start "" /wait /min "yrxitong\yr.bat"

:regimport
taskkill /f /im explorer.exe
echo [OSC]���ڵ���ע���...>"%systemdrive%\Windows\Setup\wallname.txt"
start "" /wait /min regimporter.bat
if %osver% GEQ 2 (
    %nsudo% -U:T -P:E -wait regimporter.bat
)

:misc
cd /d "%~dp0"
echo ��Դѡ������
rem POWERCFG -HIBERNATE OFF
powercfg /h off
POWERCFG -CHANGE -monitor-timeout-ac 0
POWERCFG -CHANGE -monitor-timeout-dc 0
POWERCFG -CHANGE -standby-timeout-ac 0
POWERCFG -CHANGE -standby-timeout-dc 0
POWERCFG -CHANGE -hibernate-timeout-ac 0
POWERCFG -CHANGE -hibernate-timeout-dc 0
rem [��������Դ���ر�]
powercfg setactive SCHEME_BALANCED && powercfg -x -monitor-timeout-ac 0
powercfg setactive SCHEME_MAX && powercfg -x -monitor-timeout-ac 0
powercfg setactive SCHEME_MIN && powercfg -x -monitor-timeout-ac 0
rem [���̵�Դ���ر�]
powercfg setactive SCHEME_BALANCED && powercfg -x -disk-timeout-ac 0
powercfg setactive SCHEME_MAX && powercfg -x -disk-timeout-ac 0
powercfg setactive SCHEME_MIN && powercfg -x -disk-timeout-ac 0

if %osver% GEQ 2 (
    echo win7����ϵͳ��������
    rem powercfg /h on
)
if %osver% GEQ 3 (
    echo win8����ϵͳ���ÿ�������
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
)

echo �ָ���������
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /f
if exist "%SystemDrive%\windows\system32\srclient.dll" (
    start "" /min %srtool% /off
    start "" /min %srtool% /reset
)

if %osver% GEQ 4 (
    for /f "tokens=6 delims=[]. " %%a in ('ver') do set bigversion=%%a
    for /f "tokens=7 delims=[]. " %%b in ('ver') do set smallversion=%%b
    rem �ر�ң�����ƻ�����
    sc config DiagTrack start= disabled
    sc config dmwappushservice start= demand
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Autochk\Proxy"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"

    rem �ر�ң��
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t "REG_DWORD" /d "0" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t "REG_DWORD" /d "1" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t "REG_DWORD" /d "0" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v "CEIPEnable" /t "REG_DWORD" /d "0" /f
    rem �ر�Ӧ�ó���ң��
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t "REG_DWORD" /d "0" /f
    rem �����嵥�ռ���
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t "REG_DWORD" /d "1" /f
    rem ��Ϻͷ���
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0" /f
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0" /f
    rem ����Ӧ��ʹ���ҵĹ�� ID ����չʾ���Ի���� - ��
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
    rem �����Ƶ�����
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f
    rem ī����д�ͼ������
    rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t "REG_DWORD" /d "1" /f
    rem reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "AllowLinguisticDataCollection" /t "REG_DWORD" /d "0" /f

    rem ���üƻ����� App�б���
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\AppListBackup\Backup"

    rem ���üƻ����� Windows Defender ����ά������"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" 

    rem ���üƻ����� Windows Defender ������������"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" 

    rem ���üƻ����� Windows Defender ����ɨ������"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" 

    rem ���üƻ����� Windows Defender ������֤����"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" 

    rem ���üƻ����� WindowsUpdate ����ɨ��
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_OobeAppReady"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\Report policies"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
    SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Application Experience\SdbinstMergeDbTask" 

    rem ���������ӳ�
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f

    rem ���û���¼ʱ��������˽��������
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d 1 /f

    rem �豸��������ʾ�ѽ��õ��豸
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowHiddenDevices" /t REG_DWORD /d 1 /f

    rem �豸��������ʾ�ѶϿ����豸
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowDisconnectedDevices" /t REG_DWORD /d 1 /f

    rem �� Windows ѡ��������������
    @rem reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 1 /f

    rem �رտ�ʼ�˵����������е�Ӧ�ó�����ʾ����򿪵��ļ�/�ļ���
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

    rem �رտ�ʼ�˵�����ʾ�����鰲װ��Ӧ�á����
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f

    rem ����ʾ "Windows ѯ�������"
    reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f

    rem ��Windows��⵽ͨ�Żʱ����ִ���κβ���
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d 3 /f

    rem �һ����صĴ�������Դ����ѡ��
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 45bcc044-d885-43e2-8605-ee0ec6e96b59 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 -ATTRIB_HIDE
    powercfg -attributes 2E601130-5351-4d9d-8E04-252966BAD054 d502f7ee-1dc7-4efd-a55d-f04b6f5c0545 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4e4450b3-6179-4e91-b8f1-5bb9938f81a1 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 -ATTRIB_HIDE
    powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 d639518a-e56d-4345-8af2-b9f32fb26109 -ATTRIB_HIDE
    powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 d3d55efd-c1ff-424e-9dc3-441be7833010 -ATTRIB_HIDE
    powercfg -attributes 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 -ATTRIB_HIDE
    powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 2a737441-1930-4402-8d77-b2bebba308a3 -ATTRIB_HIDE
    powercfg -attributes 4faab71a-92e5-4726-b531-224559672d19 4faab71a-92e5-4726-b531-224559672d19 -ATTRIB_HIDE
    powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 0b2d69d7-a2a1-449c-9680-f91c70521c60 -ATTRIB_HIDE
    powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 dab60367-53fe-4fbc-825e-521d069d2456 -ATTRIB_HIDE
    powercfg -attributes 48672F38-7A9A-4bb2-8BF8-3D85BE19DE4E 2bfc24f9-5ea2-4801-8213-3dbae01aa39d -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 8baa4a8a-14c6-4451-8e8b-14bdbd197537 -ATTRIB_HIDE
    powercfg -attributes 5FB4938D-1EE8-4b0f-9A3C-5036B0AB995C dd848b2a-8a5d-4451-9ae2-39cd41658f6c -ATTRIB_HIDE
    powercfg -attributes DE830923-A562-41AF-A086-E3A2C6BAD2DA 5c5bb349-ad29-4ee2-9d0b-2b25270f7a81 -ATTRIB_HIDE
    powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 -ATTRIB_HIDE
    powercfg -attributes DE830923-A562-41AF-A086-E3A2C6BAD2DA 5C5BB349-AD29-4ee2-9D0B-2B25270F7A81 -ATTRIB_HIDE
    powercfg -attributes 9596FB26-9850-41fd-AC3E-F7C3C00AFD4B 34C7B99F-9A6D-4b3c-8DC7-B6693B78CEF4 -ATTRIB_HIDE
    powercfg -attributes 9596FB26-9850-41fd-AC3E-F7C3C00AFD4B 10778347-1370-4ee0-8bbd-33bdacaade49 -ATTRIB_HIDE
    powercfg -attributes 8619B916-E004-4dd8-9B66-DAE86F806698 82011705-FB95-4D46-8D35-4042B1D20DEF -ATTRIB_HIDE
    powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 684C3E69-A4F7-4014-8754-D45179A56167 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 cfeda3d0-7697-4566-a922-a9086cd49dfa -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 bae08b81-2d5e-4688-ad6a-13243356654b -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 984cf492-3bed-4488-a8f9-4286c97bf5aa -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 93b8b6dc-0698-4d1c-9ee4-0644e900c85d -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 -ATTRIB_HIDE
    powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 -ATTRIB_HIDE
    powercfg -attributes 2E601130-5351-4d9d-8E04-252966BAD054 C42B79AA-AA3A-484b-A98F-2CF32AA90A28 -ATTRIB_HIDE
    powercfg -attributes 2a737441-1930-4402-8d77-b2bebba308a3 0853a681-27c8-4100-a2fd-82013e970683 -ATTRIB_HIDE
    powercfg -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 51dea550-bb38-4bc4-991b-eacf37be5ec8 -ATTRIB_HIDE
    powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 25DFA149-5DD1-4736-B5AB-E8A37B5B8187 -ATTRIB_HIDE
    powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 94AC6D29-73CE-41A6-809F-6363BA21B47E -ATTRIB_HIDE
    powercfg -attributes 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 -ATTRIB_HIDE

    rem ��Դģʽ��� ׿Խģʽ
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

    if !bigversion! GEQ 22000 (
        echo ����Win11��С�˵����뷨��ѡ�������С����
        reg add HKCU\Software\Microsoft\InputMethod\CandidateWindow\CHS\1 /v FontStyleTSF3 /t REG_SZ /d "18.00pt;Regular;;Microsoft YaHei UI" /f
        
        echo ����Win11��ʼ�˵��̶���
        if exist "startmenu11.ppkg" (
            echo ��װԤ���
            powershell -Command "Install-ProvisioningPackage -PackagePath .\startmenu11.ppkg -ForceInstall -QuietInstall"
            echo ж��Ԥ���
            powershell -Command "Uninstall-ProvisioningPackage -PackagePath .\startmenu11.ppkg"
        )
    )
) else if %osver% GEQ 2 (
    schtasks /change /tn "\Microsoft\Windows\SystemRestore\SR" /disable 
    schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable 
    schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable 
    schtasks /change /tn "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /disable 
    schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable 
    rem schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /disable 
    schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable 
    schtasks /change /tn "\Microsoft\Windows\WindowsBackup\ConfigNotification" /disable 
    schtasks /change /tn "\Microsoft\Windows\Location\Notifications" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\ActivateWindowsSearch" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\ConfigureInternetTimeService" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\DispatchRecoveryTasks" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\ehDRMInit" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\InstallPlayReady" /disable 
    schtasks /change /tn "\Microsoft\Windows\Media Center\mcupdate" /disable 
)

echo ˢ�������
start /min gpupdate /force
echo [OSC]�����Ż����������...>"%systemdrive%\Windows\Setup\wallname.txt"
if exist "FUCKBrowserConfig.bat" start "" /wait /min "FUCKBrowserConfig.bat"
if exist "bookmarks.exe" start "" /wait /min "bookmarks.exe"
start explorer.exe
exit