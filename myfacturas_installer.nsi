!include 'MUI2.nsh'
!include 'FileFunc.nsh'
!include 'LogicLib.nsh'
!include 'Sections.nsh'
!include 'x64.nsh'
!include 'StrContains.nsh'
!include 'EnvVarUpdate.nsh'
!include 'InstallOptions.nsh'
!include 'TextFunc.nsh'
!include 'AstiUtils.nsh'


!define PUBLISHER 'ASTI Consultoria de Software S.A. de C.V.'

!define MAJOR_VERSION '2'

!define MINOR_VERSION '4'

!define REVISION_VERSION '5'

!define VERSION "${MAJOR_VERSION}.${MINOR_VERSION}-${REVISION_VERSION}"

!define PRODUCT_NAME "MyFacturasPlus"

!define DISPLAY_NAME "${PRODUCT_NAME} ${VERSION}"

!define UNINSTALL_REGKEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME} ${VERSION}"


; To change from default installer icon:
Icon ".\pixmaps\app-icon.ico"
!define MUI_ICON ".\pixmaps\app-icon.ico" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_HEADER_TRANSPARENT_TEXT ""

!insertmacro MUI_PAGE_LICENSE ".\LICENSE"
!insertmacro MUI_LANGUAGE "Spanish"

; The name of the installer
Name '${DISPLAY_NAME}'

; The setup filename
OutFile "myfacturas-plus-${VERSION}.exe"

; The default installation directory
InstallDir $PROGRAMFILES\MyFacturasPlus

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\MyFacturasPlus" "Install_Dir"

RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "MyFacturasPlus (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath "$INSTDIR\bin"
  
  File /r "bin\*"
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\${PRODUCT_NAME} "Install_Dir" "$INSTDIR"
  
  ;Shortcuts
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME} ${VERSION}.lnk" "$INSTDIR\bin\${PRODUCT_NAME}.exe"
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\bin\${PRODUCT_NAME}.exe"
  
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "${UNINSTALL_REGKEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${UNINSTALL_REGKEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "${UNINSTALL_REGKEY}" "NoModify" 1
  WriteRegDWORD HKLM "${UNINSTALL_REGKEY}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
  WriteRegStr HKLM       "${UNINSTALL_REGKEY}" "Publisher" "${PUBLISHER}"
  WriteRegStr HKLM       "${UNINSTALL_REGKEY}" "DisplayVersion" "${VERSION}"
  WriteRegStr HKLM       "${UNINSTALL_REGKEY}" "DisplayIcon" "$INSTDIR\pixmaps\app-icon.ico"
  WriteRegDWORD HKLM     "${UNINSTALL_REGKEY}" "Version" "${VERSION}"
  WriteRegDWORD HKLM     "${UNINSTALL_REGKEY}" "VersionMajor" "${MAJOR_VERSION}.${MINOR_VERSION}"
  WriteRegDWORD HKLM     "${UNINSTALL_REGKEY}" "VersionMinor" "${REVISION_VERSION}"
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"

  ; Remove links files and links
  Delete "$INSTDIR\*"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME} ${VERSION}.lnk"
  RmDir "$SMPROGRAMS\${PRODUCT_NAME}"
  ; Remove registry key
  DeleteRegKey HKLM "${UNINSTALL_REGKEY}"
  ; Remove uninstaller and instdir
  Delete $INSTDIR\uninstall.exe
  RmDir /r "$INSTDIR\"
  
SectionEnd


