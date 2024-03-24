; ��װ�����ʼ���峣��
!define PRODUCT_NAME "��Ȼϵͳ�Ż�����"
!define PRODUCT_DESC "Optimize System Configurations"
; !define /date PRODUCT_VERSION "2.24.%m.%d"
!define PRODUCT_PUBLISHER "Xiaoran Studio"
!define PRODUCT_WEB_SITE "https://xrgzs.github.io/"
!define PRODUCT_VERSION "${CUSTOM_VERSION}"

; ʵ�ⲻѹ��ʵ��С
SetCompressor lzma
SetCompressorDictSize 32

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON ".\osc.ico"

; ��ӭҳ��
; !insertmacro MUI_PAGE_WELCOME
; Components page
; !insertmacro MUI_PAGE_COMPONENTS
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
; !insertmacro MUI_PAGE_FINISH

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} V${PRODUCT_VERSION}"
OutFile "osc.exe"
InstallDir "$WINDIR\Setup\Set\osc"
ShowInstDetails show
BrandingText "${PRODUCT_NAME} V${PRODUCT_VERSION}"

; info of installer execute file
VIProductVersion "${PRODUCT_VERSION}" ;�汾�ţ���ʽΪ X.X.X.X (��ʹ����������)
VIAddVersionKey FileDescription "${PRODUCT_DESC}" ;�ļ�����(��׼��Ϣ)
VIAddVersionKey FileVersion "${PRODUCT_VERSION}" ;�ļ��汾(��׼��Ϣ)
VIAddVersionKey ProductName "${PRODUCT_NAME} V${PRODUCT_VERSION}" ;��Ʒ����
VIAddVersionKey ProductVersion "${PRODUCT_VERSION}" ;��Ʒ�汾
VIAddVersionKey Comments "${PRODUCT_NAME} V${PRODUCT_VERSION}" ;��ע
VIAddVersionKey CompanyName "${PRODUCT_PUBLISHER}" ;��˾��
VIAddVersionKey LegalCopyright "Copyright @ 2024 ${PRODUCT_PUBLISHER}. All Rights Reserved." ;�Ϸ���Ȩ
VIAddVersionKey InternalName "${PRODUCT_NAME}" ;�ڲ�����
VIAddVersionKey LegalTrademarks "${PRODUCT_PUBLISHER}" ;�Ϸ��̱� ;
VIAddVersionKey OriginalFilename "osc.exe" ;Դ�ļ���
VIAddVersionKey PrivateBuild "XRSYS" ;�����ڲ��汾˵��
VIAddVersionKey SpecialBuild "NSIS" ;�����ڲ��汾˵��

Section "XROSC" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on
  DetailPrint "��ѹ�������..."
  File /r ".\osc\*.*"
  DetailPrint "����OSC������..."
  ExecShellWait "open" "$INSTDIR\osc.bat" SW_SHOWMINIMIZED
SectionEnd

Section -Post
SectionEnd
