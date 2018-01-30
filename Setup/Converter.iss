; Inno Setup.
; ���������� � ���������� ������������, ����� ������������ ��� ����������� INNO SETUP!

#define MyAppName "���������"
#define MyAppVersion "1.1.2.347"
#define MyAppPublisher "Pavel Krezub"
#define MyAppURL "https://github.com/Apik21/Converter"
#define MyAppExeName "Converter.exe"

[Setup]
; ����������: �������� AppId �������� ���������� ��������������� ��� ����� ����������.
; �� ����������� ���� � ���� �������� AppId ��� ������ ����������.
; (��� �������� ������ �������� GUID, �������� � ���� "�����������" ����� "������� GUID".)
AppId={{B728FEF6-1C4B-4F52-B172-F3F91234A984}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=D:\AHK\GitHub\Converter\Setup\License.txt
InfoBeforeFile=D:\AHK\GitHub\Converter\Setup\sys.txt
OutputDir=D:\AHK\GitHub\Converter\
OutputBaseFilename=ConverterSetup
SetupIconFile=D:\AHK\GitHub\Converter\Setup\conv2.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "D:\AHK\GitHub\Converter\Setup\Converter.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\AHK\GitHub\Converter\Setup\Compi\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\AHK\GitHub\Converter\Setup\License.txt"; DestDir: "{app}"; Flags: ignoreversion
; ����������: �� ����������� ����� "ignoreversion" ��� ����� ��������� ������.

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

