; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Android Police's Send To: Watermark"
!define PRODUCT_PUBLISHER "Ron Amadeo"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "..\resources\AP icon.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Android Police\Send To Watermark"
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "..\AP_Watermark.bat"
  File "..\ImageMagick\convert.exe"
  File "..\ImageMagick\vcomp100.dll"
  File "..\ImageMagick\composite.exe"
  File "..\resources\AP icon.ico"
  File "..\resources\AP_Vid_Watermark.png"
  CreateDirectory "$SENDTO"
  CreateShortCut "$SENDTO\AP Watermark.lnk" "$INSTDIR\AP_Watermark.bat" "" "$INSTDIR\AP icon.ico"
SectionEnd

Section -AdditionalIcons
  CreateDirectory "$SMPROGRAMS\Android Police Send To Watermark"
  CreateShortCut "$SMPROGRAMS\Android Police Send To Watermark\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\AP_Vid_Watermark.png"
  Delete "$INSTDIR\AP_Watermark.bat"
  Delete "$INSTDIR\composite.exe"
  Delete "$INSTDIR\convert.exe"
  Delete "$INSTDIR\vcomp100.dll"
  Delete "$INSTDIR\AP icon.ico"
  Delete "$SMPROGRAMS\Android Police Send To -> Watermark\Uninstall.lnk"
  Delete "$SENDTO\AP Watermark.lnk"

  RMDir "$SMPROGRAMS\Android Police Send To -> Watermark"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd