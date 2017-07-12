; Inno Setup.
; ОБРАТИТЕСЬ К СПРАВОЧНОЙ ДОКУМЕНТАЦИИ, ЧТОБЫ ИСПОЛЬЗОВАТЬ ВСЕ ВОЗМОЖНОСТИ INNO SETUP!

#define MyAppName "Конвертер"
#define MyAppVersion "1.1.2.340"
#define MyAppPublisher "Pavel Krezub"
#define MyAppURL "https://github.com/Apik21/Converter"
#define MyAppExeName "converter.exe"

[Setup]
; Примечание: Значение AppId является уникальным идентификатором для этого приложения.
; Не используйте одно и тоже значение AppId для разных приложений.
; (Для создания нового значения GUID, выберите в меню "Инструменты" пункт "Создать GUID".)
AppId={{7A68008F-615D-435A-8C34-B298FC68FAF2}
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
LicenseFile=D:\AHK\1.1.2\Converter\Setup\License.txt
InfoBeforeFile=D:\AHK\1.1.2\Converter\Setup\sys.txt
OutputDir=D:\AHK\1.1.2\Converter\
OutputBaseFilename=ConverterSetup
SetupIconFile=D:\AHK\1.1.2\Converter\Setup\conv2.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "D:\AHK\1.1.2\Converter\Setup\converter.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\AHK\1.1.2\Converter\Setup\Compi\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\AHK\1.1.2\Converter\Setup\License.txt"; DestDir: "{app}"; Flags: ignoreversion
; Примечание: Не используйте флаги "ignoreversion" для общих системных файлов.

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

