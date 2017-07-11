#NoEnv          ; для производительности и совместимости с будущими AutoHotkey-релизы.
#Persistent     ; Выполнять скрипт, пока не закроет пользователь.
#IfWinActive, ahk_class AutoHotkeyGUI ;работает только в активном GUI, при сворачивании ожидает активации окна.
#SingleInstance Force ; старый экземпляр скрипта будет замещён новым автоматически, без вывода диалогового окна.
#Include Functions.ahk

SendMode Input  ; для новых сценариев, обеспечение высокой скорости и надежности.
SetWorkingDir %A_ScriptDir%  ; Обеспечивает согласованность c начальныv каталогом.
FileCreateDir, %A_Temp%\DBFFC.tmp
FileCreateDir, %A_AppData%\Конвертер\Logs

Gui, 26: Color, White
Gui, 26: Font, cRed S16 W700
Gui, 26: +AlwaysOnTop -border -Caption +Owner +ToolWindow
Gui, 26: Add, text, ,`tЗагрузка...`n `n Подождите несколько секунд.`n`n`n`t`t©Krezub Pavel
Gui, 26: Show, Center, app
WinSet, TransColor, White, app
gosub, Label1
IfWinActive, Конвертер
	Gui, 26: Submit
return

Label1:
global Vers
global sborka
global dev_sborka
global DnDJpeg
global DnDPdf
global DnDTiff
global DnDDoc
global DnDPng
global PageN
global LogLine
global CmdLog
global gs
global cv
global sys

;***************Проверка разрядности системы************************************************************
ThisProcess := DllCall("GetCurrentProcess")
if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
    IsWow64Process := false
Sys := % IsWow64Process ? "win64" : "win32"
if sys = "win64"
{
	gs = gswin64c.exe
	cv = cvert64.exe
}
else
{
	gs = gswin32c.exe
	cv = cvert.exe
}
;***********************************************************************************************
;***************Переменные настройки************************************************************
;***********************************************************************************************
sborka = 340                                  ; Номер сборки версии
dev_sborka = https://raw.githubusercontent.com/Apik21/Converter/master/sborka.txt ;Сборка с сайта
Vers = v1.1.2								  ; Номер версисии комбайна
PageN = 1251                                  ; Номер кодовой страницы
Repo = https://rawgit.com/Apik21/Converter/master/ConverterPortable.exe ; Адрес программы для обновления
LogPath = %A_AppData%\Конвертер\Logs\         ; Путь к папле для создания логов
LogLine = "=========================================== `%date`% - `%time`% ================================================"
CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
;***********************************************************************************************
;***********************************************************************************************
;***********************************************************************************************



;================================/INCLUDE===========================================================
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\fonts
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\locale\de\LC_MESSAGES
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\locale\lp\LC_MESSAGES
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\locale\pt\LC_MESSAGES
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\locale\ru-blocked\LC_MESSAGES
FileCreateDir, %A_Temp%\DBFFC.tmp\p2d\locale\uk\LC_MESSAGES
FileCreateDir, %A_Temp%\DBFFC.tmp\Sourse
FileInstall, Sourse\tb2bt.exe, %A_Temp%\DBFFC.tmp\tb2bt.exe
FileInstall, Sourse\bsed.exe, %A_Temp%\DBFFC.tmp\bsed.exe
FileInstall, Sourse\cvert.exe, %A_Temp%\DBFFC.tmp\cvert.exe
FileInstall, Sourse\cvert64.exe, %A_Temp%\DBFFC.tmp\cvert64.exe
FileInstall, Sourse\gswin64c.exe, %A_Temp%\DBFFC.tmp\gswin64c.exe
FileInstall, Sourse\gsdll64.dll, %A_Temp%\DBFFC.tmp\gsdll64.dll
FileInstall, Sourse\gsdll64.lib, %A_Temp%\DBFFC.tmp\gsdll64.lib
FileInstall, Sourse\gswin32c.exe, %A_Temp%\DBFFC.tmp\gswin32c.exe
FileInstall, Sourse\gsdll32.dll, %A_Temp%\DBFFC.tmp\gsdll32.dll
FileInstall, Sourse\gsdll32.lib, %A_Temp%\DBFFC.tmp\gsdll32.lib
FileInstall, Sourse\libiconv2.dll, %A_Temp%\DBFFC.tmp\libiconv2.dll
FileInstall, Sourse\pdftk.exe, %A_Temp%\DBFFC.tmp\pdftk.exe
FileInstall, Sourse\doc2fb.xsl, %A_Temp%\DBFFC.tmp\doc2fb.xsl
FileInstall, Sourse\doc.bat, %A_Temp%\DBFFC.tmp\doc.bat
FileInstall, help\1.chm, %A_Temp%\DBFFC.tmp\1.chm
FileInstall, P2D\bzz.exe, %A_Temp%\DBFFC.tmp\p2d\bzz.exe
FileInstall, P2D\c44.exe, %A_Temp%\DBFFC.tmp\p2d\c44.exe
FileInstall, P2D\cjb2.exe, %A_Temp%\DBFFC.tmp\p2d\cjb2.exe
FileInstall, P2D\csepdjvu.exe, %A_Temp%\DBFFC.tmp\p2d\csepdjvu.exe
FileInstall, P2D\djvmcvt.exe, %A_Temp%\DBFFC.tmp\p2d\djvmcvt.exe
FileInstall, P2D\djvuextract.exe, %A_Temp%\DBFFC.tmp\p2d\djvuextract.exe
FileInstall, P2D\djvumake.exe, %A_Temp%\DBFFC.tmp\p2d\djvumake.exe
FileInstall, P2D\djvused.exe, %A_Temp%\DBFFC.tmp\p2d\djvused.exe
FileInstall, P2D\libdjvulibre-21.dll, %A_Temp%\DBFFC.tmp\p2d\libdjvulibre-21.dll
FileInstall, P2D\libexiv2-14.dll, %A_Temp%\DBFFC.tmp\p2d\libexiv2-14.dll
FileInstall, P2D\libexpat-1.dll, %A_Temp%\DBFFC.tmp\p2d\libexpat-1.dll
FileInstall, P2D\libfontconfig-1.dll, %A_Temp%\DBFFC.tmp\p2d\libfontconfig-1.dll
FileInstall, P2D\libfreetype-6.dll, %A_Temp%\DBFFC.tmp\p2d\libfreetype-6.dll
FileInstall, P2D\libgcc_s_sjlj-1.dll, %A_Temp%\DBFFC.tmp\p2d\libgcc_s_sjlj-1.dll
FileInstall, P2D\libGraphicsMagick-3.dll, %A_Temp%\DBFFC.tmp\p2d\libGraphicsMagick-3.dll
FileInstall, P2D\libGraphicsMagick++-11.dll, %A_Temp%\DBFFC.tmp\p2d\libGraphicsMagick++-11.dll
FileInstall, P2D\libiconv.dll, %A_Temp%\DBFFC.tmp\p2d\libiconv.dll
FileInstall, P2D\libintl-8.dll, %A_Temp%\DBFFC.tmp\p2d\libintl-8.dll
FileInstall, P2D\libjpeg-62.dll, %A_Temp%\DBFFC.tmp\p2d\libjpeg-62.dll
FileInstall, P2D\libpoppler-19.dll, %A_Temp%\DBFFC.tmp\p2d\libpoppler-19.dll
FileInstall, P2D\libstdc++-6.dll, %A_Temp%\DBFFC.tmp\p2d\libstdc++-6.dll
FileInstall, P2D\pdf2djvu.exe, %A_Temp%\DBFFC.tmp\p2d\pdf2djvu.exe
FileInstall, p2d\etc\fonts\fonts.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\fonts.conf
FileInstall, p2d\etc\fonts\conf.d\30-metric-aliases.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\30-metric-aliases.conf
FileInstall, p2d\etc\fonts\conf.d\30-urw-aliases.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fontsconf.d\30-urw-aliases.conf
FileInstall, p2d\etc\fonts\conf.d\40-nonlatin.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\40-nonlatin.conf
FileInstall, p2d\etc\fonts\conf.d\45-latin.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\45-latin.conf
FileInstall, p2d\etc\fonts\conf.d\49-sansserif.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\49-sansserif.conf
FileInstall, p2d\etc\fonts\conf.d\50-user.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\50-user.conf
FileInstall, p2d\etc\fonts\conf.d\51-local.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\51-local.conf
FileInstall, p2d\etc\fonts\conf.d\60-latin.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\60-latin.conf
FileInstall, p2d\etc\fonts\conf.d\65-fonts-persian.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\65-fonts-persian.conf
FileInstall, p2d\etc\fonts\conf.d\65-nonlatin.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\65-nonlatin.conf
FileInstall, p2d\etc\fonts\conf.d\69-unifont.conf, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\69-unifont.conf
FileInstall, p2d\fonts\a010013l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\a010013l.pfb
FileInstall, p2d\fonts\a010015l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\a010015l.pfb
FileInstall, p2d\fonts\a010033l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\a010033l.pfb
FileInstall, p2d\fonts\a010035l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\a010035l.pfb
FileInstall, p2d\fonts\b018012l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\b018012l.pfb
FileInstall, p2d\fonts\b018015l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\b018015l.pfb
FileInstall, p2d\fonts\b018032l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\b018032l.pfb
FileInstall, p2d\fonts\b018035l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\b018035l.pfb
FileInstall, p2d\fonts\c059013l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\c059013l.pfb
FileInstall, p2d\fonts\c059016l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\c059016l.pfb
FileInstall, p2d\fonts\c059033l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\c059033l.pfb
FileInstall, p2d\fonts\c059036l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\c059036l.pfb
FileInstall, p2d\fonts\d050000l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\d050000l.pfb
FileInstall, p2d\fonts\n019003l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019003l.pfb
FileInstall, p2d\fonts\n019004l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019004l.pfb
FileInstall, p2d\fonts\n019023l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019023l.pfb
FileInstall, p2d\fonts\n019024l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019024l.pfb
FileInstall, p2d\fonts\n019043l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019043l.pfb
FileInstall, p2d\fonts\n019044l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019044l.pfb
FileInstall, p2d\fonts\n019063l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019063l.pfb
FileInstall, p2d\fonts\n019064l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n019064l.pfb
FileInstall, p2d\fonts\n021003l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n021003l.pfb
FileInstall, p2d\fonts\n021004l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n021004l.pfb
FileInstall, p2d\fonts\n021023l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n021023l.pfb
FileInstall, p2d\fonts\n021024l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n021024l.pfb
FileInstall, p2d\fonts\n022003l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n022003l.pfb
FileInstall, p2d\fonts\n022004l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n022004l.pfb
FileInstall, p2d\fonts\n022023l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n022023l.pfb
FileInstall, p2d\fonts\n022024l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\n022024l.pfb
FileInstall, p2d\fonts\p052003l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\p052003l.pfb
FileInstall, p2d\fonts\p052004l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\p052004l.pfb
FileInstall, p2d\fonts\p052023l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\p052023l.pfb
FileInstall, p2d\fonts\p052024l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\p052024l.pfb
FileInstall, p2d\fonts\s050000l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\s050000l.pfb
FileInstall, p2d\fonts\z003034l.pfb, %A_Temp%\DBFFC.tmp\p2d\fonts\z003034l.pfb
FileInstall, p2d\locale\de\LC_MESSAGES\pdf2djvu.mo, %A_Temp%\DBFFC.tmp\p2d\locale\de\LC_MESSAGES\pdf2djvu.mo
FileInstall, p2d\locale\pl\LC_MESSAGES\pdf2djvu.mo, %A_Temp%\DBFFC.tmp\p2d\locale\pl\LC_MESSAGES\pdf2djvu.mo
FileInstall, p2d\locale\pt\LC_MESSAGES\pdf2djvu.mo, %A_Temp%\DBFFC.tmp\p2d\locale\pt\LC_MESSAGES\pdf2djvu.mo
FileInstall, p2d\locale\ru-blocked\LC_MESSAGES\pdf2djvu.mo, %A_Temp%\DBFFC.tmp\p2d\locale\ru-blocked\LC_MESSAGES\pdf2djvu.mo
FileInstall, p2d\locale\uk\LC_MESSAGES\pdf2djvu.mo, %A_Temp%\DBFFC.tmp\p2d\locale\uk\LC_MESSAGES\pdf2djvu.mo

FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\tb2bt.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\bsed.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\cvert.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gswin64c.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gsdll64.dll,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gsdll64.lib,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\cvert64.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gswin32c.exe,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gsdll32.dll,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\gsdll32.lib,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\libiconv2.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\pdftk.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\doc.bat ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\doc2fb.xsl ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\1.chm ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\bzz.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\c44.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\cjb2.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\csepdjvu.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\djvmcvt.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\djvuextract.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\djvumake.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\djvused.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libdjvulibre-21.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libexiv2-14.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libexpat-1.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libfontconfig-1.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libfreetype-6.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libgcc_s_sjlj-1.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libGraphicsMagick-3.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libGraphicsMagick++-11.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libiconv.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libintl-8.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libjpeg-62.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libpoppler-19.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\libstdc++-6.dll ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\pdf2djvu.exe ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\fonts.conf
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\30-metric-aliases.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\30-urw-aliases.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\40-nonlatin.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\45-latin.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\49-sansserif.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\50-user.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\51-local.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\60-latin.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\65-fonts-persian.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\65-nonlatin.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\etc\fonts\conf.d\69-unifont.conf ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\a010013l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\a010015l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\a010033l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\a010035l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\b018012l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\b018015l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\b018032l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\b018035l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\c059013l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\c059016l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\c059033l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\c059036l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\d050000l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019003l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019004l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019023l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019024l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019043l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019044l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019063l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n019064l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n021003l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n021004l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n021023l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n021024l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n022003l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n022004l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n022023l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\n022024l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\p052003l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\p052004l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\p052023l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\p052024l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\s050000l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\fonts\z003034l.pfb ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\locale\de\LC_MESSAGES\pdf2djvu.mo ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\locale\pl\LC_MESSAGES\pdf2djvu.mo ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\locale\pt\LC_MESSAGES\pdf2djvu.mo ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\locale\ru-blocked\LC_MESSAGES\pdf2djvu.mo ,0,0
FileSetAttrib, +HT, %A_Temp%\DBFFC.tmp\p2d\locale\uk\LC_MESSAGES\pdf2djvu.mo ,0,0

;================================INCLUDE\===========================================================


;================================GUI/===============================================================
Gui, +hwndhGui1 + OwnDialogs +lastfound
Menu, Option, Add, &Открыть логи, LogOpen
Menu, Option, Add, &Настройки, Options
Menu, Option, Add, О&бновление, Update
Menu, HelpMenu, Add, &Справка, HelpAbout
Menu, MyMenuBar, Add, Параметры, :Option
Menu, MyMenuBar, Add, Справка (F1), :HelpMenu ; Создаем строку меню, присоединяя к ней подменю:

Menu, Tray, NoStandard
Menu, Tray, MainWindow
Menu, pConvert, add, Jpg->Pdf, JP
Menu, pConvert, add, Pdf->Jpg, PJ
Menu, pConvert, add, Jpg->Tiff, JT
Menu, pConvert, add, Tiff->Jpg, TJ
Menu, pZip, add, JPG, ZJ
Menu, pZip, add, PDF, ZP
Menu, pZip, add, TIFF, ZT
Menu, Tray, add, Конвертация, :pConvert
Menu, Tray, add, Сжатие, :pZip
Menu, Tray, add
Menu, Tray, add, Закрыть, TEX
Menu, Tray, Tip, Ковертер изображений
Gui, Menu, MyMenuBar ; Присоединяем строку меню к окну:

Gui, Add, GroupBox, x5 y0 w120 h125 cRed, Конвертирование из
Gui, Add, GroupBox, x210 y0 w80 h120 cRed, Сжатие
Gui, Add, Button, x12 y20 w50 h30 , JPG
Gui, Add, Button, x12 y52 w50 h30 , PDF
Gui, Add, Button, x65 y20 w50 h30 , TIFF
Gui, Add, Button, x65 y52 w50 h30 gDOC, DOC
Gui, Add, Button, x12 y84 w50 h30 , PNG
Gui, Add, Progress, x5 y135 w200 h20 Smooth vProgr
Gui, Add, Button, x230 y130 w60 h30 gTEX, Выход
Gui, Add, Button, x225 y20 w50 h30 gZJ, J P G
Gui, Add, Button, x225 y50 w50 h30 gZP, P D F
Gui, Add, Button, x225 y80 w50 h30 gZT, T I F F
Gui, Add, Button, x130 y27 w75 h30 gDt, Дата
Gui, Add, Button, x130 y60 w75 h30 gBas, Шифрование
Gui, Add, StatusBar,,
SB_SetParts(150, 110)
SB_SetText("Версия " . Vers . "." . sborka, 2)
SB_SetText(	A_Hour . ":" . A_Min, 3)
SetTimer, BarTime, 3000
SB_SetIcon("shell32.dll", 266)
Gui, Default

Gui, 2:+hwndhGui2 +owner1 -Caption +Border
Gui, 2:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 2:Add, Text, x70 y5 w150 h30 r2 , Степень сжатия (качество)`n 1-max 99-min
Gui, 2:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 2:Add, Button, x5 y70 w100 h30 , OK
Gui, 2:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 3:Add, CheckBox, x5 y5 w200 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 3:Add, Button, x5 y40 w100 h30 , OK
Gui, 3:Add, Button, x115 y40 w100 h30 , Отмена

Gui, 4:+hwndhGui4 +owner1 -Caption +Border
Gui, 4:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 4:Add, Text, x70 y5 w150 h30 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 4:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 4:Add, Button, x5 y70 w100 h30 , OK
Gui, 4:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 5:+hwndhGui5 +owner1 -Caption +Border
Gui, 5:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 5:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 5:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество) `n 1-max 99-min
Gui, 5:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 5:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 5:Add, Button, x5 y85 w100 h30 , OK
Gui, 5:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 6:+hwndhGui6 +owner1 -Caption +Border
Gui, 6:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 6:Add, Text, x70 y5 w150 h30 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 6:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 6:Add, Button, x5 y70 w100 h30 , OK
Gui, 6:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 7:+hwndhGui7 +owner1 -Caption +Border
Gui, 7:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 7:Add, Text, x70 y5 w150 h30 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 7:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 7:Add, Button, x5 y70 w100 h30 , OK
Gui, 7:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 8:+hwndhGui8 +owner1 -Caption +Border
Gui, 8:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 8:Add, Text, x70 y5 w150 h30 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 8:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 8:Add, Button, x5 y70 w100 h30 , OK
Gui, 8:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 9:+hwndhGui9 +owner1 -Caption +Border
Gui, 9:Add, Button, x2 y5 w80 h30 , Сжать
Gui, 9:Add, Button, x2 y40 w80 h30 gVost, Восстановить
Gui, 9:Add, Button, x84 y5 w80 h30 , Разрезать
Gui, 9:Add, Button, x84 y40 w80 h30 , Склеить
Gui, 9:Add, Button, x166 y5 w75 h30 gMD, Изм. Мета.
Gui, 9:Add, Button, x166 y40 w75 h30 gDSh, Защита

Gui, 10:+hwndhGui10 +owner1 -Caption +Border
Gui, 10:Add, Edit, x5 y10 w250 h25 vStran
Gui, 10:Add, Text, x5 y30 w350 h30, Укажите сохраняемые страницы:1, 3-5, 8 Для поворота после страницы указать сторну поворота: left, right, down. См. справку.
Gui, 10:Add, Button, x5 y70 w140 h30 gSplt, Сохранить выбранные страницы
Gui, 10:Add, Button, x160 y70 w60 h30 , Отмена

Gui, 11:+hwndhGui11 +owner1 -Caption +Border
Gui, 11:Add, Text, x10 y5 w290 h20 , В какой формат будем конвертировать документ?
Gui, 11:Add, Button, x5 y30 w60 h30 , HTML
Gui, 11:Add, Button, x70 y30 w60 h30 , RTF
Gui, 11:Add, Button, x135 y30 w60 h30 , MHT
Gui, 11:Add, Button, x200 y30 w60 h30 gTxt, TXT
Gui, 11:Add, Button, x200 y65 w60 h30 gXml, XML
Gui, 11:Add, Button, x135 y65 w60 h30 gPdf, PDF
Gui, 11:Add, Button, x70 y65 w60 h30 gXps, XPS
Gui, 11:Add, Button, x5 y65 w60 h30 gFb2, FB2

Gui, 12: +hwndhGui12 +owner1 -Caption +Border
Gui, 12:Add, Text, x12 y0 w230 h30 , В какой формат будем конвертировать?
Gui, 12:Add, Button, x5 y15 w50 h30 gJP, PDF
Gui, 12:Add, Button, x60 y15 w50 h30 gJT, TIFF
Gui, 12:Add, Button, x115 y15 w50 h30 gJPs, PS
Gui, 12:Add, Button, x170 y15 w50 h30 gJPn, PNG
Gui, 12:Add, Button, x5 y50 w50 h30 gJJ, JPEG
Gui, 12:Add, Button, x60 y50 w50 h30 gJI, ICO
Gui, 12:Add, Button, x115 y50 w50 h30 gJE, EMF
Gui, 12:Add, Button, x170 y50 w50 h30 gJB, BMP

Gui, 13:+hwndhGui13 +owner1 -Caption +Border
Gui, 13:Add, Text, x12 y0 w230 h30 , В какой формат будем конвертировать?
Gui, 13:Add, Button, x5 y15 w50 h30 gPJ, JPEG
Gui, 13:Add, Button, x60 y15 w50 h30 gPTc, TIFF(цв)
Gui, 13:Add, Button, x115 y15 w50 h30 gPTb, TIFF(ч/б)
Gui, 13:Add, Button, x170 y15 w50 h30 gPTx, TXT
Gui, 13:Add, Button, x225 y15 w50 h30 gPD, DJVU

Gui, 14:+hwndhGui14 +owner1 -Caption +Border
Gui, 14:Add, Text, x12 y0 w230 h30 , В какой формат будем конвертировать?
Gui, 14:Add, Button, x5 y15 w50 h30 gTJ, JPEG
Gui, 14:Add, Button, x60 y15 w50 h30 gTPs, PS
Gui, 14:Add, Button, x115 y15 w50 h30 gTPn, PNG
Gui, 14:Add, Button, x5 y50 w50 h30 gTP, PDF
Gui, 14:Add, Button, x60 y50 w50 h30 gTI, ICO
Gui, 14:Add, Button, x115 y50 w50 h30 gTE, EMF
Gui, 14:Add, Button, x170 y50 w50 h30 gTB, BMP

Gui, My:+hwndhGuiMy +Resize +HwndMyGuiHwnd  ; Задаем окну свойство изменять размер.
Gui, My:Add, Button, x5 y5, Сохранить
Gui, My:Add, Button, x80 y5, Выход
Gui, My:Add, Edit, x5 y40 W400 R30 vMeta,

Gui, 15:+hwndhGui15 +owner1 -Caption +Border
Gui, 15:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 15:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 15:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 15:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 15:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 15:Add, Button, x5 y85 w100 h30 , OK
Gui, 15:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 16:+hwndhGui16 +owner1 -Caption +Border
Gui, 16:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 16:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 16:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 16:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 16:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 16:Add, Button, x5 y85 w100 h30 , OK
Gui, 16:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 17:+hwndhGui17 +owner1 -Caption +Border
Gui, 17:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 17:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 17:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 17:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 17:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 17:Add, Button, x5 y85 w100 h30 , OK
Gui, 17:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 18:+hwndhGui18 +owner1 -Caption +Border
Gui, 18:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 18:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 18:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 18:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 18:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 18:Add, Button, x5 y85 w100 h30 , OK
Gui, 18:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 19:+hwndhGui19 +owner1 -Caption +Border
Gui, 19:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 19:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 19:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 19:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 19:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 19:Add, Button, x5 y85 w100 h30 , OK
Gui, 19:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 20:+hwndhGui20 +owner1 -Caption +Border
Gui, 20:Add, Edit, x5 y5 w50 h20 vZip , 85
Gui, 20:Add, Edit, x5 y35 w50 h20 vPage, 0
Gui, 20:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 20:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
Gui, 20:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
Gui, 20:Add, Button, x5 y85 w100 h30 , OK
Gui, 20:Add, Button, x115 y85 w100 h30 , Отмена

Gui, 21:+hwndhGui21 +owner1 -Caption +Border
Gui, 21:Add, Text, x2 y0 w300 h40 , Изменение даты и времени создания/изменения/доступа к файлу.`nЧто будем менять?
Gui, 21:Add, Text, x2 y45 w300 h20 , Введите значение нового времени по образцу:
Gui, 21:Add, Edit, x2 y70 w150 h20 vVremya , %A_Now%
Gui, 21:Add, Button, x1 y95 w80 h40 gVI, Время изменения
Gui, 21:Add, Button, x82 y95 w80 h40 gVS, Время создания
Gui, 21:Add, Button, x163 y95 w80 h40 gVD, Время последнего доступа

Gui, 22: +hwndhGui22 +owner1 -Caption +Border
Gui, 22:Add, Text, x12 y0 w230 h30 , В какой формат будем конвертировать?
Gui, 22:Add, Button, x5 y15 w50 h30 gPP, PDF
Gui, 22:Add, Button, x60 y15 w50 h30 gPT, TIFF
Gui, 22:Add, Button, x115 y15 w50 h30 gPPs, PS
Gui, 22:Add, Button, x170 y15 w50 h30 gPnJ, JPG
Gui, 22:Add, Button, x5 y50 w50 h30 gPJe, JPEG
Gui, 22:Add, Button, x60 y50 w50 h30 gPI, ICO
Gui, 22:Add, Button, x115 y50 w50 h30 gPE, EMF
Gui, 22:Add, Button, x170 y50 w50 h30 gPB, BMP

Gui, 23:+hwndhGui23 +owner1 -Caption +Border
Gui, 23:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 23:Add, Text, x70 y5 w150 h30 r2 , Степень сжатия (качество)`n 1-max 99-min
Gui, 23:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 23:Add, Button, x5 y70 w100 h30 , OK
Gui, 23:Add, Button, x115 y70 w100 h30 , Отмена

Gui, 24:+hwndhGui24 +owner1 -Caption +Border
Gui, 24:Add, Edit, x5 y5 w60 h25 vZip , 85
Gui, 24:Add, Text, x70 y5 w150 h30 r2, Степень сжатия (качество)`n 1-max 99-min
Gui, 24:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 24:Add, Button, x5 y70 w100 h30 , OK
Gui, 24:Add, Button, x115 y70 w100 h30 , Отмена

Int = 1
Gui, 25:+hwndhGui25 +owner1 -Caption +Border
Gui, 25:Add, Text, x2 y0 w300 h20 , Шифрование и дешифровка файлов по алгоритму Base64
Gui, 25:Add, Edit, x5 y25 w20 h20 vInt, %Int%
Gui, 25:Add, Text, x30 y25 w270 h20  , Количество циклов де-/шифрования (см. Справку).
Gui, 25:Add, Button, x5 y50 w70 h40 gBasE, Шифровать
Gui, 25:Add, Button, x80 y50 w80 h40 gBasD, Дешифровать
Gui, 25:Add, Button, x165 y50 w80 h40 gTb2bt, Шиф./Дешиф. текст

;Gui, 26:Add, В резерве

Gui, 27:Add, GroupBox, x3 y11 w150 h180 , Кодовая страница
Gui, 27:Add, CheckBox, Checked 1 x15 y23 w100 h30 vWin gUpPage1, - 1251 Windows
Gui, 27:Add, CheckBox, x15 y46 w100 h30 vDos gUpPage2, - 866 Dos
Gui, 27:Add, CheckBox, x15 y72 w100 h30 vIso gUpPage3, - 28595 ISO
Gui, 27:Add, CheckBox, x15 y97 w100 h30 vKoir gUpPage4, - 20866 KOI8-R
Gui, 27:Add, CheckBox, x15 y122 w100 h30 vKoiu gUpPage5, - 21866 KOI8-U
Gui, 27:Add, CheckBox, x15 y148 w100 h30 vMac gUpPage6, - 10007 Mac
Gui, 27:Add, GroupBox, x162 y13 w252 h178 , Обновление
Gui, 27:Add, Text, x170 y35 w150 h20 , Проверка обновлений
Gui, 27:Add, Edit, x170 y56 w227 h20 vRepo, %Repo%
Gui, 27:Add, Button, x100 y210 w100 h30 , Сохранить
GuiControl, 27:Disabled, - 866 Dos
GuiControl, 27:Disabled, - 28595 ISO
GuiControl, 27:Disabled, - 20866 KOI8-R
GuiControl, 27:Disabled, - 21866 KOI8-U
GuiControl, 27:Disabled, - 10007 Mac
GuiControlGet, Upd,, Upd

VarSetCapacity(WI, 64)
Sleep, 1024
Gui, Show, Center h190 w300, Конвертер 

Return

GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y)
{
	If A_EventInfo = 1 
	{
		for i, Files in FileArray
		{
			SplitPath, Files,, Dir, Ext, Name
	   ; Сжатие перетаскиваемых файлов
			If (((Ext = "jpg") && (A_GuiControl = "T I F F")) || ((Ext = "jpg") && (A_GuiControl = "J P G")) || ((Ext = "jpg") && (A_GuiControl = "P D F")) || ((Ext = "jpg") && (A_GuiControl = "Сжатие")))
			{
				conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 8 -q 50 -multi -o "%Dir%\%Name%_#.jpg" "%Files%"
				WaitProgress(1)
				RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				WaitProgress(0, %A_LastError%, %ErrorLevel%)
			}
			else If (((Ext = "jpeg") && (A_GuiControl = "T I F F")) || ((Ext = "jpeg") && (A_GuiControl = "J P G")) || ((Ext = "jpeg") && (A_GuiControl = "P D F")) || ((Ext = "jpeg") && (A_GuiControl = "Сжатие")))
			{
				conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 8 -q 50 -multi -o "%Dir%\%Name%_#.jpg" "%Files%"
				WaitProgress(1)
				RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				WaitProgress(0, %A_LastError%, %ErrorLevel%)
			}					
			else If (((Ext = "pdf") && (A_GuiControl = "T I F F")) || ((Ext = "pdf") && (A_GuiControl = "P D F")) || ((Ext = "pdf") && (A_GuiControl = "J P G")) || ((Ext = "pdf") && (A_GuiControl = "Сжатие")))
			{
				FileCreateDir, %A_Temp%\DBFFC.tmp\{ZipPdfFile}
				export = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=jpeg -dNOPAUSE -r150  -sOutputFile="%A_Temp%\DBFFC.tmp\{ZipPdfFile}\%Name%`%02d.jpg" "%Files%" -c quit
				conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q 50 -multi -o "%dir%\%Name%_zip.pdf" "%A_Temp%\DBFFC.tmp\{ZipPdfFile}\*.jpg"
				WaitProgress(1)
				RunWait, %comspec% /c %CmdLog% && %export% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				FileRemoveDir, %A_Temp%\DBFFC.tmp\{ZipPdfFile}, 1
				WaitProgress(0, %A_LastError%, %ErrorLevel%)
			} 
			else if (((Ext = "tiff") && (A_GuiControl = "T I F F")) || ((Ext = "tif") && (A_GuiControl = "T I F F")) || ((Ext = "tiff") && (A_GuiControl = "P D F")) || ((Ext = "tif") && (A_GuiControl = "P D F")) || ((Ext = "tiff") && (A_GuiControl = "J P G")) || ((Ext = "tif") && (A_GuiControl = "J P G")) || ((Ext = "tiff") && (A_GuiControl = "Сжатие")) || ((Ext = "tif") && (A_GuiControl = "Сжатие")))
			{
				conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -c 5 -q 50 -multi -o "%Dir%\%Name%_#.tiff" "%Files%"
				WaitProgress(1)
				RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				WaitProgress(0, %A_LastError%, %ErrorLevel%)
			}
			; Конвертирование перетаскиваемых файлов
			else if ((Ext = "jpg") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDJpeg = %Files%
				gosub, BJPG
			}
			else if ((Ext = "jpeg") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDJpeg = %Files%
				gosub, BJPG
			}
			else if ((Ext = "pdf") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDPdf = %Files%
				gosub, BPDF
			}
			else if ((Ext = "tiff") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDTiff = %Files%
				gosub, BTIFF
			}
			else if ((Ext = "tif") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDTiff = %Files%
				gosub, BTIFF
			}
			else if ((Ext = "doc") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "docx") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "html") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "xml") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "rtf") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "mht") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "txt") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDDoc = %Files%
				gosub, BDOC
			}
			else if ((Ext = "png") && (A_GuiControl = "TIFF") || (A_GuiControl = "PDF") || (A_GuiControl = "JPG") || (A_GuiControl = "DOC") || (A_GuiControl = "PNG") || (A_GuiControl = "Конвертирование из"))
			{
				DnDPng = %Files%
				gosub, BPNG
			}
			else 
			{
				MsgBox, 4148, Ошибка, Файлы перемещены не в блок обработки`, либо данный тип файлов не поддерживается. Открыть справку "Функция Drag-and-Drop"?
				IfMsgBox Yes
					Run, "%A_Temp%\DBFFC.tmp\1.chm"
				else return
			}
		}
	}
	If (A_EventInfo > 1)  ; при передаче более одного jpg файла конвертировать в pdf
	{
		for i, Files in FileArray
		{
			SplitPath, Files,, Dir, Ext, Name
			if (((Ext = "jpg") && (A_GuiControl = "TIFF")) || ((Ext = "jpg") && (A_GuiControl = "PDF")) || ((Ext = "jpg") && (A_GuiControl = "JPG")) || ((Ext = "jpg") && (A_GuiControl = "DOC")) || ((Ext = "jpg") && (A_GuiControl = "PNG")) || ((Ext = "jpg") && (A_GuiControl = "Конвертирование из")))
			{
				jj=1
				pp=0
				if i = 1
					DnDJpeg = "%Files%"
				else
					DnDJpeg = %DnDJpeg% "%Files%"
			}
			else if (((Ext = "jpeg") && (A_GuiControl = "TIFF")) || ((Ext = "jpeg") && (A_GuiControl = "PDF")) || ((Ext = "jpeg") && (A_GuiControl = "JPG")) || ((Ext = "jpeg") && (A_GuiControl = "DOC")) || ((Ext = "jpeg") && (A_GuiControl = "PNG")) || ((Ext = "jpeg") && (A_GuiControl = "Конвертирование из")))
			{
				jj=1
				pp=0
				if i = 1
					DnDJpeg = "%Files%"
				else
					DnDJpeg = %DnDJpeg% "%Files%"
			}
			; при передаче более одного pdf файла склеить в pdf
			else if (((Ext = "pdf") && (A_GuiControl = "T I F F")) || ((Ext = "pdf") && (A_GuiControl = "P D F")) || ((Ext = "pdf") && (A_GuiControl = "J P G")) || ((Ext = "pdf") && (A_GuiControl = "Сжатие")))
			{
				jj=0
				pp=1
				if i = 1
					DnDpdf = "%Files%" 
				else
					DnDPdf = %DnDpdf% "%Files%"
			} 
			else
			{
				jj=0
				pp=0
				MsgBox, 4144, Ошибка, Передано более одного файла с расширением отличным от поддерживаемого jpg/jpeg/pdf. Будте терпеливы и повторите попытку.
				return
			}
		}
		
		If ((jj=1) && (pp=0))
		{
			conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -c 5 -q 85 -multi -o "%Dir%\%Name%.pdf" %DnDJpeg%
			WaitProgress(1)
			RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
			WaitProgress(0, %A_LastError%, %ErrorLevel%)
			DnDJpeg = ""
		}
		else if ((jj=0) && (pp=1))
		{
			merge = "%A_Temp%\DBFFC.tmp\%gs%" -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -sDEVICE=pdfwrite -sOutputFile="%Dir%\%Name%_#.pdf" %DnDPdf%
			WaitProgress(1)
			RunWait, %comspec% /c %CmdLog% && %merge% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
			WaitProgress(0, %A_LastError%, %ErrorLevel%)
			DnDPdf = ""
		}
	}
}	
Return

;================================GUI\===============================================================

BarTime:
SB_SetText(A_Hour . ":" . A_Min, 3)
return

;================================MAIN/=========================================================

;***********************************************************************************************
;*****************************OPTIONS***********************************************************
;***********************************************************************************************
Options:
Gui 27:Show, ,Настройки
return

UpPage1:
GuiControlGet, Win,, Win
If Win =1
{
	global PageN = 1251
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 866 Dos
	GuiControl, 27:Disabled, - 28595 ISO
	GuiControl, 27:Disabled, - 20866 KOI8-R
	GuiControl, 27:Disabled, - 21866 KOI8-U
	GuiControl, 27:Disabled, - 10007 Mac
}
else
{
	GuiControl, 27:Enabled, - 866 Dos
	GuiControl, 27:Enabled, - 28595 ISO
	GuiControl, 27:Enabled, - 20866 KOI8-R
	GuiControl, 27:Enabled, - 21866 KOI8-U
	GuiControl, 27:Enabled, - 10007 Mac
}
return

UpPage2:
GuiControlGet, Dos,, Dos
If Dos =1
{
	global PageN = 866
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 1251 Win
	GuiControl, 27:Disabled, - 28595 ISO
	GuiControl, 27:Disabled, - 20866 KOI8-R
	GuiControl, 27:Disabled, - 21866 KOI8-U
	GuiControl, 27:Disabled, - 10007 Mac
}
else
{
	GuiControl, 27:Enabled, - 1251 Win
	GuiControl, 27:Enabled, - 28595 ISO
	GuiControl, 27:Enabled, - 20866 KOI8-R
	GuiControl, 27:Enabled, - 21866 KOI8-U
	GuiControl, 27:Enabled, - 10007 Mac
}
return

UpPage3:
GuiControlGet, Iso,, Iso
If Iso =1
{
	global PageN = 28595
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 866 Dos
	GuiControl, 27:Disabled, - 1251 Win
	GuiControl, 27:Disabled, - 20866 KOI8-R
	GuiControl, 27:Disabled, - 21866 KOI8-U
	GuiControl, 27:Disabled, - 10007 Mac
}
else
{
	GuiControl, 27:Enabled, - 866 Dos
	GuiControl, 27:Enabled, - 1251 Win
	GuiControl, 27:Enabled, - 20866 KOI8-R
	GuiControl, 27:Enabled, - 21866 KOI8-U
	GuiControl, 27:Enabled, - 10007 Mac
}
return

UpPage4:
GuiControlGet, Koir,, Koir
If Koir =1
{
	global PageN = 20866
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 866 Dos
	GuiControl, 27:Disabled, - 28595 ISO
	GuiControl, 27:Disabled, - 1251 Win
	GuiControl, 27:Disabled, - 21866 KOI8-U
	GuiControl, 27:Disabled, - 10007 Mac
}
else
{
	GuiControl, 27:Enabled, - 866 Dos
	GuiControl, 27:Enabled, - 28595 ISO
	GuiControl, 27:Enabled, - 1251 Win
	GuiControl, 27:Enabled, - 21866 KOI8-U
	GuiControl, 27:Enabled, - 10007 Mac
}
return

UpPage5:
GuiControlGet, Koiu,, Koiu
If Koiu =1
{
	global PageN = 21866
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 866 Dos
	GuiControl, 27:Disabled, - 28595 ISO
	GuiControl, 27:Disabled, - 20866 KOI8-R
	GuiControl, 27:Disabled, - 1251 Win
	GuiControl, 27:Disabled, - 10007 Mac
}
else
{
	GuiControl, 27:Enabled, - 866 Dos
	GuiControl, 27:Enabled, - 28595 ISO
	GuiControl, 27:Enabled, - 20866 KOI8-R
	GuiControl, 27:Enabled, - 1251 Win
	GuiControl, 27:Enabled, - 10007 Mac
}
return

UpPage6:
GuiControlGet, Mac,, Mac
If Mac =1
{
	global PageN = 10007
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	GuiControl, 27:Disabled, - 866 Dos
	GuiControl, 27:Disabled, - 28595 ISO
	GuiControl, 27:Disabled, - 20866 KOI8-R
	GuiControl, 27:Disabled, - 21866 KOI8-U
	GuiControl, 27:Disabled, - 1251 Win
}
else
{
	GuiControl, 27:Enabled, - 866 Dos
	GuiControl, 27:Enabled, - 28595 ISO
	GuiControl, 27:Enabled, - 20866 KOI8-R
	GuiControl, 27:Enabled, - 21866 KOI8-U
	GuiControl, 27:Enabled, - 1251 Win
}
return

27ButtonСохранить:
Gui 27:Submit
return

;***********************************************************************************************
;***********************************************************************************************
;***********************************************************************************************

;===========================Меню=================================================================
F1::
HelpAbout:
Run, "%A_Temp%\DBFFC.tmp\1.chm"
return

LogOpen:
Run, "%A_AppData%\Конвертер\Logs"
return

Update:
If ConnectedToInternet()
{
	UrlDownloadToFile, https://raw.githubusercontent.com/Apik21/Converter/master/sborka.txt, %A_Temp%\DBFFC.tmp\sborka.txt
	ELM(%ErrorLevel%, Ошибка загрузки, 1)
	FileRead, new_sborka, %A_Temp%\DBFFC.tmp\sborka.txt
	ELM(%ErrorLevel%, Ошибка чтения, 1)
	If (new_sborka > sborka) 
	{
		MsgBox, 52, Обновление, Найдена новая версия программы.`n Текущая версия программы - %Vers%.%sborka%,`n Новая версия программы - %Vers%.%new_sborka%.`n Скачать обновление??
		IfMsgBox Yes
		{
			MsgBox,,Конвертер,Спасибо за ваш выбор.
			Run, %Repo%
			bat = ping 127.0.0.1 > NUL`ndel /F /Q ConverterPortable.exe`ndel /F /Q delete.bat
			FileDelete, delete.bat
			FileAppend %bat%, delete.bat
			Run delete.bat, ,Hide
			ExitApp

return
		}
	}
	else
		MsgBox,,Поздравляю!,Вы используете последнюю версию программы.
}	
else 
{
	Msgbox, 48, Ошибка подключения, Нет подключения к Интернету. Обратитесь к администратору вашей сети!
}
Return

;==========================Дата===================================================================
Dt:
gosub, allguicancel
OnMessage(0x0003, "funcdt")
OnMessage(0x112, "funcdt")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 21:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h140 w300"
   DllCall("AnimateWindow", Ptr, hGui21, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return

VI:
FileSelectFile, files, M3,,Редактирование времени изменения файла, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
{
    return
}

WinWaitClose Редактирование времени изменения файла
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
	{
    if a_index = 1
		{
		path = %A_LoopField%
    }
	else
		{
		 ; Установить дату изменения (время будет полночь):
         FileSetTime, %Vremya%, %path%\%A_LoopField% , M
		} 
	}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

VS:
FileSelectFile, files, M3,,Редактирование времени создания файла, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
{
    return
}

WinWaitClose Редактирование времени создания файла
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
	{
    if a_index = 1
		{
		path = %A_LoopField%
    }
	else
		{
		 ; Установить дату изменения (время будет полночь):
         FileSetTime, %Vremya%, %path%\%A_LoopField% , C
		} 
	}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

VD:
Gui, 21:Submit
FileSelectFile, files, M3,,Редактирование времени последнего доступа к файлу, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
{
    return
}

WinWaitClose Редактирование времени последнего доступа к файлу
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
	{
    if a_index = 1
		{
		path = %A_LoopField%
    }
	else
		{
		 ; Установить дату изменения (время будет полночь):
      FileSetTime, %Vremya%, %path%\%A_LoopField% , A
		} 
	}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

;===================================================================================================
;==========================Шифрование===============================================================
Bas:
gosub, allguicancel
OnMessage(0x0003, "funcbas")
OnMessage(0x112, "funcbas")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 25:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h100 w300"
   DllCall("AnimateWindow", Ptr, hGui25, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
Return
;===================================================================================================
BasE:
Gui 25:Submit
FileSelectFile, files, 3,,Зашифровать файл, Все файлы (*.*)
	if files =
	{
		return
	}
	WinWaitClose Зашифровать файл
	SplitPath, files, FiNam, Dir, Ext, Name
base = "%A_Temp%\DBFFC.tmp\bsed.exe" -e "%files%" "%A_Temp%\DBFFC.tmp\%FiNam%" 
GuiControlGet, Int,, Int
WaitProgress(1)
Loop %Int%
{
	RunWait, %comspec% /c %CmdLog% && %base% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
	FileDelete, "%files%"
	sleep 1000
	FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
	sleep 1000
}
WaitProgress(0, %A_LastError%, %ErrorLevel%)
Return
;===================================================================================================
BasD:
Gui 25:Cancel
FileSelectFile, files, 3,,Дешифровать файл, Все файлы (*.*)
	if files =
	{
		return
	}
WinWaitClose Дешифровать файл
SplitPath, files, FiNam, Dir, Ext, Name
base = "%A_Temp%\DBFFC.tmp\bsed.exe" -d "%files%" "%A_Temp%\DBFFC.tmp\%FiNam%" 
GuiControlGet, Int,, Int
WaitProgress(1)
Loop %Int%
{
	RunWait, %comspec% /c %CmdLog% && %base% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
	FileDelete % files
	sleep 1000
	FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
	sleep 1000
}
WaitProgress(0, %A_LastError%, %ErrorLevel%)
Return
;===================================================================================================
Tb2bt:
Gui 25:Cancel
Run, "%A_Temp%\DBFFC.tmp\tb2bt.exe"
Return

;===================================================================================================
;==========================Конвертирование Png======================================================
;===================================================================================================

ButtonPNG:
DnDPng = ""
BPNG:
gosub, allguicancel
OnMessage(0x3, "funcpng")
OnMessage(0x112, "funcpng")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 22:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h85 w300"
   DllCall("AnimateWindow", Ptr, hGui22, UInt, 300, UInt, 0x40000|(i ? 1 : 0x10002))    ;выдвигаем/задвигаем окно-слайдер
return
;==========================Конвертирование Jpg======================================================
ButtonJPG:
DnDJpeg = ""
BJPG:
gosub, allguicancel
OnMessage(0x3, "funcjpg")
OnMessage(0x112, "funcjpg")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 12:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h85 w300"
   DllCall("AnimateWindow", Ptr, hGui12, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return
;===========================Конвертирование Pdf=====================================================
ButtonPDF:
DnDPdf = ""
BPDF:
gosub, allguicancel
OnMessage(0x0003, "funcpdf")
OnMessage(0x112, "funcpdf")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 13:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h90"
   DllCall("AnimateWindow", Ptr, hGui13, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
return
;=============================Конвертирование Tiff =================================================
ButtonTIFF:
DnDTiff = ""
BTIFF:
gosub, allguicancel
OnMessage(0x0003, "functiff")
OnMessage(0x112, "functiff")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 14:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h85 w300"
   DllCall("AnimateWindow", Ptr, hGui14, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
return 
;==========================Конвертирование Jpg =====================================================

;==========================Конвертирование Jpg to Pdf===============================================
JP:
If DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to PDF, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to PDF
}

OnMessage(0x0003, "funcjp")
OnMessage(0x112, "funcjp")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	Gui, 2:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h105"
DllCall("AnimateWindow", Ptr, hGui2, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x00010008))
Gui 12:Show, hide 
Return

2ButtonOK:
GuiControlGet, del
GuiControlGet, Zip
Gui, 12:Submit
If del = 1
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q %Zip% -multi -o
else
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -c 5 -q %Zip% -multi -o
	
if DnDJpeg = ""
{
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.pdf" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%.pdf" "%DnDJpeg%"
}
Gui, 2:Submit

WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return

2ButtonОтмена:
Gui 2:Submit 
Return
;==========================Конвертирование Jpg to Ps================================================
JPs:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to PS, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Ps
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.ps" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ps" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Jpg to Png================================================
JPn:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to PNG, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Png
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.png" "
		}
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -c 5 -o "%Dir%\%Name%.png" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Jpg to Jpeg================================================
JJ:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to JPEG, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Jpeg
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.jpeg" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.jpeg" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Jpg to Ico================================================
JI:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to ICO, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Ico
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.ico" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ico" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Jpg to Emf================================================
JE:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to EMF, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to EMF
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.emf" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.emf" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;============================Конвертирование Jpg to Tiff============================================
JT:
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to TIFF, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to PDF
}
OnMessage(0x3, "funcjt")
OnMessage(0x112, "funcjt")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	Gui, 4:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h105"
	DllCall("AnimateWindow", Ptr, hGui4, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
Gui 12:Show, hide 
return
	
4ButtonOK:
Gui, 12:Submit
GuiControlGet, Del
GuiControlGet, Zip
Gui, 4:Submit
If del = 1
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -D -c 5 -q %Zip% -multi -o
else
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -c 5 -q %Zip% -multi -o
IF DnDJpeg = ""
{
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.tiff" "
		}
		else
			conv = %conv%%path%\%A_LoopField%" " 
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" %conv% "%Dir%\%Name%.tiff" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

4ButtonОтмена:
Gui 4:Submit 
return
;==========================Конвертирование Jpg to Bmp================================================
JB:
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to BMP, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to BMP
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path = %A_LoopField%
			conv=%conv% "%path%\`%.bmp" "
        }
		else
			conv = %conv%%path%\%A_LoopField%" "
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.bmp" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return                                                                                           
;==========================Конвертирование PNG======================================================================================

;==========================Конвертирование PNG to Pdf===============================================================================
PP:
If DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to PDF, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация PNG to PDF
}

OnMessage(0x0003, "funcpp")
OnMessage(0x112, "funcpp")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	Gui, 23:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h105"
DllCall("AnimateWindow", Ptr, hGui23, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x00010008))
Gui 22:Show, hide 
Return

23ButtonOK:
GuiControlGet, del
GuiControlGet, Zip
Gui, 23:Submit
If del = 1
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q %Zip% -o
else
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -c 5 -q %Zip% -o
	
if DnDPng = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%.pdf" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%.pdf" "%DnDPng%"
}

Gui, 22:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return

23ButtonОтмена:
Gui 23:Submit 
Return
;==========================Конвертирование Png to Ps================================================
PPs:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to PS, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация PNG to PS 
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%dir%\%name%.ps" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ps" "%DnDPn%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Png to Jpg================================================
PnJ:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация Png to Jpg, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация Png to Jpg
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 5 -o "%dir%\%name%.jpg" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 5 -o "%Dir%\%Name%.jpg" "%DnDPng%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Png to Jpeg================================================
PJe:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to JPEG, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация PNG to Jpeg
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 5 -o "%dir%\%name%.jpeg" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.jpeg" "%DnDPng%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Png to Ico================================================
PI:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to ICO, Изображения (*.png) 
	if files =
		return
	WinWaitClose Конвертация PNG to ICO
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -c 5 -o "%dir%\%name%.ico" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ico" "%DnDPng%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;==========================Конвертирование Png to Emf================================================
PE:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to EMF, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация PNG to EMF
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -c 5 -o "%dir%\%name%.emf" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 5 -o "%Dir%\%Name%.emf" "%DnDPng%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;============================Конвертирование Png to Tiff============================================
PT:
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to TIFF, Изображения (*.png)
	if files =
		return
	WinWaitClose Конвертация PNG to TIFF
}
OnMessage(0x3, "funcpt")
OnMessage(0x112, "funcpt")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
		Gui, 24:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h105"
   DllCall("AnimateWindow", Ptr, hGui24, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
Gui 22:Show, hide 
return
	
24ButtonOK:
Gui, 22:Submit
GuiControlGet, Del
GuiControlGet, Zip
Gui, 24:Submit
If del = 1
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -D -c 5 -q %Zip% -o
else
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -c 5 -q %Zip% -o
IF DnDPng = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%.tiff" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%.tiff" "%DnDPng%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

24ButtonОтмена:
Gui 24:Submit 
return
;==========================Конвертирование Png to Bmp================================================
PB:
Gui, 22:Submit
IF DnDPng = ""
{
	FileSelectFile, files, 3,,Конвертация PNG to BMP, Изображения (*.png) 
	if files =
		return
	WinWaitClose Конвертация PNG to BMP
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -c 5 -o "%dir%\%name%.bmp" "%files%"
}
else
{
	SplitPath, DnDPng,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -c 5 -o "%Dir%\%Name%.bmp" "%DnDPng%"

}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return                                                
;===========================Конвертирование Pdf=====================================================================================

;===========================Конвертирование Pdf to Jpg============================================================================  
PJ:
IF DnDPdf = ""
{
	FileSelectFile, files,3,,Конвертация PDF to JPG, Изображения (*.pdf)
	if files =
		return
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=jpeg -dNOPAUSE -r150  -sOutputFile="%dir%\%name%`%02d.jpg" "%files%" -c quit
}
else
{
	SplitPath, DnDPdf,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=jpeg -dNOPAUSE -r150  -sOutputFile="%Dir%\%Name%`%02d.jpg" "%DnDPdf%" -c quit
}
OnMessage(0x3, "funcpj")
OnMessage(0x112, "funcpj")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 3:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h70 w300"
   DllCall("AnimateWindow", Ptr, hGui3, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 13:Submit
return

3ButtonOK:
GuiControlGet, Del
Gui, 3:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
	If del = 1
	{
		FileSetAttrib, -R, %files%
		FileDelete, %files%
		sleep 500
		ControlClick, JPG,Конвертер, , LEFT
	}
	else
		ControlClick, JPG,Конвертер, , LEFT
WaitProgress(0, %A_LastError%, %ErrorLevel%)
Return	

3ButtonОтмена:
Gui 3:Submit 
return
;===========================Конвертирование Pdf to Tiff(цветной)==============================================  
PTc:
IF DnDPdf = ""
{
	FileSelectFile, files,3,,Конвертация PDF to Tiff(цветной), Изображения (*.pdf)
	if files =
		return
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=tiff24nc -dNOPAUSE -r150  -sOutputFile="%dir%\%name%.tiff" "%files%" -c quit
}
else
{
	SplitPath, DnDPdf,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=tiff24nc -dNOPAUSE -r150  -sOutputFile="%Dir%\%Name%.tiff" "%DnDPdf%" -c quit
}
Gui 13:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;===========================Конвертирование Pdf to Tiff(ч/б)==============================================  
PTb:
IF DnDPdf = ""
{
	FileSelectFile, files,3,,Конвертация PDF to Tiff(ч/б), Изображения (*.pdf)
	if files =
		return
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=tiffscaled8 -dNOPAUSE -r150  -sOutputFile="%dir%\%name%.tiff" "%files%" -c quit
}
else
{
	SplitPath, DnDPdf,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=tiffscaled8 -dNOPAUSE -r150  -sOutputFile="%Dir%\%Name%.tiff" "%DnDPdf%" -c quit
}
Gui 13:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;===========================Конвертирование Pdf to Txt==============================================  
PTx:
IF DnDPdf = ""
{
	FileSelectFile, files,3,,Конвертация PDF to Txt, Документ (*.pdf)
	if files =
		return
	SplitPath, files,, dir,,name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=txtwrite -dNOPAUSE -r150  -sOutputFile="%dir%\%name%.txt" "%files%" -c quit
	
}
else
{
	SplitPath, DnDPdf,, Dir, Ext, Name
	conv = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=txtwrite -dNOPAUSE -r150  -sOutputFile="%Dir%\%Name%.txt" "%DnDPdf%" -c quit
}
Gui 13:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;===========================Конвертирование Pdf to DJVU==============================================  
PD:
IF DnDPdf = ""
{
	FileSelectFile, files,3,,Конвертация PDF to DJVU, Документ (*.pdf)
	if files =
		return
	SplitPath, files,, dir,,name
	conv = "%A_WorkingDir%\p2d\pdf2djvu.exe" -o "%dir%\%name%.djvu"   --verbatim-metadata --page-id-template=nb{dpage:04*}.djvu "%files%" 
}
else
{
	SplitPath, DnDPdf,, Dir, Ext, Name
	conv = "%A_WorkingDir%\p2d\pdf2djvu.exe" -o "%dir%\%name%.djvu"   --verbatim-metadata --page-id-template=nb{dpage:04*}.djvu "%DnDPdf%" 
}
Gui 13:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return
;=============================Конвертирование Tiff to Jpg===========================================
TJ:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to JPG", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to JPG"
}
OnMessage(0x3, "functj")
OnMessage(0x112, "functj")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
  ;if i := !i
      Gui, 5:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"

   DllCall("AnimateWindow", Ptr, hGui5, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

5ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 5:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -D -c 8 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 8 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -D -c 8 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 8 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.jpg" "%files%"
}
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.jpg" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

5ButtonОтмена:
Gui 5:Submit 
return
;=============================Конвертирование Tiff to Ps===========================================
TPs:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to PS", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to PS"
}
OnMessage(0x3, "functps")
OnMessage(0x112, "functps")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 15:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"

   DllCall("AnimateWindow", Ptr, hGui15, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

15ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 15:Submit
if Page = 0
{
	if Del =1
		conv ="%A_Temp%\DBFFC.tmp\%cv%" -out ps -D -c 8 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 8 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -D -c 8 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ps -c 8 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.ps" "%files%"
}
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.ps" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

15ButtonОтмена:
Gui 15:Submit 
return
;=============================Конвертирование Tiff to PNG===========================================
TPn:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to PNG", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to PNG"
}
OnMessage(0x3, "functpn")
OnMessage(0x112, "functpn")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 16:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"
   DllCall("AnimateWindow", Ptr, hGui16, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

16ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 16:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -D -c 8 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -c 8 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -D -c 8 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out png -c 8 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.png" "%files%"
}
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.png" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

16ButtonОтмена:
Gui 16:Submit 
return
;=============================Конвертирование Tiff to PDF===========================================
TP:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to PDF", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to PDF"
}
OnMessage(0x3, "functp")
OnMessage(0x112, "functp")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 17:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"
   DllCall("AnimateWindow", Ptr, hGui17, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

17ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 17:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q %Zip% -xall -o ; 
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -c 5 -q %Zip% -xall -o    ; 
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -c 5 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.pdf" "%files%"
}	
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.pdf" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

17ButtonОтмена:
Gui 17:Submit 
return
;=============================Конвертирование Tiff to Ico===========================================
TI:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to Ico", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to Ico"
}
OnMessage(0x3, "functi")
OnMessage(0x112, "functi")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 18:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"
   DllCall("AnimateWindow", Ptr, hGui18, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

18ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 18:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -D -c 8 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -c 8 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -D -c 8 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out ico -c 8 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.ico" "%files%"
}	
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.ico" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
sleep 500
ControlClick, JPG,Конвертер, , LEFT
Return	

18ButtonОтмена:
Gui 18:Submit 
return
;=============================Конвертирование Tiff to EMF===========================================
TE:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to EMF", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to EMF"
}
OnMessage(0x3, "functe")
OnMessage(0x112, "functe")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 19:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"
   DllCall("AnimateWindow", Ptr, hGui19, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

19ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 19:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -D -c 5 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -c 5 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -D -c 5 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out emf -c 5 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.emf" "%files%"
}	
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.emf" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

19ButtonОтмена:
Gui 19:Submit 
return
;=============================Конвертирование Tiff to BMP===========================================
TB:
if DnDTiff = ""
{
	FileSelectFile, files, 3,,"Конвертация TIFF to BMP", Изображения (*.tiff; *.tif)
	if files =
		return
	WinWaitClose "Конвертация TIFF to BMP"
}
OnMessage(0x3, "functb")
OnMessage(0x112, "functb")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 20:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h115 w300"
   DllCall("AnimateWindow", Ptr, hGui20, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
Gui 14:Submit
return

20ButtonOK:
GuiControlGet, Del
GuiControlGet, Page
Gui, 20:Submit
if Page = 0
{
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -D -c 5 -q %Zip% -xall -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -c 5 -q %Zip% -xall -o
}
else
{
Page := Page-1
	if Del =1
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -D -c 5 -q %Zip% -page %Page% -o
	else
		conv = "%A_Temp%\DBFFC.tmp\%cv%" -out bmp -c 5 -q %Zip% -page %Page% -o
}
if DnDTiff = ""
{
	SplitPath, files,, dir,,name
	conv = %conv% "%dir%\%name%-#.bmp" "%files%"
}
else
{
	SplitPath, DnDTiff,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%-#.bmp" "%DnDTiff%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

20ButtonОтмена:
Gui 20:Submit 
return
;=============================Сжатие Jpg============================================================
ZJ:
gosub, allguicancel
FileSelectFile, files, M3,,Сжатие JPG, Изображения (*.jpg; *.jpeg)
if files =
    return

WinWaitClose Сжатие JPG
OnMessage(0x3, "funczj")
OnMessage(0x112, "funczj")   ; M_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 6:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h105"
   DllCall("AnimateWindow", Ptr, hGui6, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
	return

6ButtonOK:
GuiControlGet, Del
GuiControlGet, Zip

If del = 1
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -D -c 8 -q %Zip% -multi -o
else
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out jpeg -c 8 -q %Zip% -multi -o

Loop, parse, files, `n
{
    if a_index = 1
	{
		path = %A_LoopField%
		conv=%conv% "%path%\`%.jpg" "
    }
	else
		conv = %conv%%path%\%A_LoopField%" "
}
Gui, 6:Submit

StringTrimRight, conv, conv, 2
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

6ButtonОтмена:
Gui 6:Submit 
return
;==============================Блок сжатия и т.д. Pdf===============================================
ZP:
gosub, allguicancel
OnMessage(0x3, "funczp")
OnMessage(0x112, "funczp")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 9:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h80 w300"
   DllCall("AnimateWindow", Ptr, hGui9, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return

9ButtonСклеить:
Gui 9:Submit
{
FileSelectFile, files, M3,,Обработка PDF,PDF Files (*.pdf)
if files =
    return
merge = "%A_Temp%\DBFFC.tmp\%gs%" -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -sDEVICE=pdfwrite -sOutputFile=

Loop, parse, files, `n
{
    if (a_index = 1)
		path = %A_LoopField%
	else if (a_index = 2)
	{
		temp = %merge%"%path%\#%A_LoopField%"
		merge = %temp% "%path%\%A_LoopField%"
	}
	else	
		merge = %merge% "%path%\%A_LoopField%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %merge% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
}
Return

9ButtonРазрезать:
Gui 9:Submit

FileSelectFile, files,3,,Разрезать PDF, Изображения (*.pdf)
if files =
    return
SplitPath, files,, dir,,name
WinWaitClose Разрезать PDF
OnMessage(0x3, "funczpsp")
OnMessage(0x112, "funczpsp")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 10:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h105 w360"
   DllCall("AnimateWindow", Ptr, hGui10, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008)) 
return

Splt:
GuiControlGet, Stran

Value1 := ". " 
Value2 := ", "
Value3 := "/ "
Value4 := "." 
Value5 := ","
Value6 := "/"
StringReplace, Stran1, Stran, %Value1%,%A_Space%, All
StringReplace, Stran2, Stran1, %Value2%,%A_Space%, All
StringReplace, Stran3, Stran2, %Value3%,%A_Space%, All
StringReplace, Stran4, Stran3, %Value4%,%A_Space%, All
StringReplace, Stran5, Stran4, %Value5%,%A_Space%, All
StringReplace, Stran6, Stran5, %Value6%,%A_Space%, All

split = "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" cat %Stran6% output "%dir%\%name%New.pdf"
Gui 10:Submit

WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %split% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return

9ButtonСжать:
Gui 9:Submit

FileSelectFile, files,3,,Сжатие PDF, Изображения (*.pdf)
if files =
    return
SplitPath, files,, dir,,name
FileCreateDir, %A_Temp%\{41243843A44243E4402042643E4392041643843221}
export = "%A_Temp%\DBFFC.tmp\%gs%"  -sDEVICE=jpeg -dNOPAUSE -r150  -sOutputFile="%A_Temp%\{41243843A44243E4402042643E4392041643843221}\%name%`%02d.jpg" "%files%" -c quit

WinWaitClose Сжатие PDF
OnMessage(0x3, "funczpz")
OnMessage(0x112, "funczpz")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
      Gui, 8:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h105 w300"
   DllCall("AnimateWindow", Ptr, hGui8, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008)) 
return

8ButtonOK:
GuiControlGet, Del
GuiControlGet, Zip
conv = "%A_Temp%\DBFFC.tmp\%cv%" -out pdf -D -c 5 -q %Zip% -multi -o "%dir%\%name%#.pdf" "%A_Temp%\{41243843A44243E4402042643E4392041643843221}\*.jpg"
Gui, 8:Submit
WaitProgress(1)
	RunWait, %comspec% /c %CmdLog% && %export% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
    RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
	FileRemoveDir, %A_Temp%\{41243843A44243E4402042643E4392041643843221}, 1
WaitProgress(0, %A_LastError%, %ErrorLevel%)
	If del = 1
	{
		FileSetAttrib, -R, %files%
		FileDelete, %files%
		sleep 500
		ControlClick, JPG, Конвертер, , LEFT
	}
	else
		ControlClick, JPG, Конвертер, , LEFT
Return	

;===================================================================================================
MD:
Gui 9:Submit

FileSelectFile, files,3,,Изменение метаданных PDF, Изображения (*.pdf)
if files =
    return
SplitPath, files,, dir,,name
IfExist, "%A_Temp%\DBFFC.tmp\metadata.txt"
    FileDelete, "%A_Temp%\DBFFC.tmp\metadata.txt"
metdo= "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" dump_data output %A_Temp%\DBFFC.tmp\metadata.txt
metdi= "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" update_info %A_Temp%\DBFFC.tmp\metadata.txt output "%dir%\%name%01.pdf"
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %metdo% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
sleep 2500
;===================================================================================================

;==========================================/BLOC====================================================


MetaFile = %A_Temp%\DBFFC.tmp\metadata.txt
FileRead, Meta1, %MetaFile%
If ErrorLevel <> 0
{
	MsgBox Нельзя открыть метаданные.
    return
} 
Gui, My:Show,, METADATA
Gui, My:Default
WinWait, METADATA
GuiControl,, Meta, %Meta1% ; Помещаем текст в элемент управления.
return

MyButtonСохранить:  ; Вызывающий оператор гарантирует, что MetaFile имеет значение.
IfExist, %MetaFile%
{
    FileDelete, %MetaFile%
    If ErrorLevel <> 0
    {
        MsgBox Попытка сохранить метаданные потерпела неудачу.
        return
    }
}
Gui, My:Default
GuiControlGet, Meta ; Извлекаем содержимое поля редактирования.
FileAppend, %Meta%, %MetaFile% ; Сохраняем содержимое в файле.
Gui My:Submit
sleep 500
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %metdi% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
GUI Default
sleep 500
ControlClick, PDF,Конвертер, , LEFT
sleep 2500
FileDelete, %A_Temp%\DBFFC.tmp\metadata.txt
WaitProgress(0, %A_LastError%, %ErrorLevel%)
return

MyGuiSize:
Gui, My:Default
if ErrorLevel = 1 ; Окно минимизировано.  Ничего делать не нужно.
    return
; Иначе, был изменен размер окна или окно было увеличено до максимального размера.
; Чтобы поле редактирования соответствовало новому размеру окна, изменяем его размер.
NewWidth := A_GuiWidth-5
NewHeight := A_GuiHeight-20
GuiControl, Move, Meta, W%NewWidth% H%NewHeight%
return

MyButtonВыход:
MyGuiClose: ; при нажатии кнопки закрытия окна
MyGuiEscape: ; при нажатии кнопки ESC  
FileDelete, %A_Temp%\DBFFC.tmp\metadata.txt 
Gui My:Submit
GUI Default
sleep 500
ControlClick, PDF,Конвертер, , LEFT
return
;===============================BLOC\===============================================================
DSh:
{
MsgBox, 35, Защита,Хотите защитить документ? Если нет, то снятие защиты.
	IfMsgBox Yes
	{
		Gui 9:Submit
		FileSelectFile, files,3,,Защита PDF, Изображения (*.pdf)
		if files =
			return
		SplitPath, files,, dir,,name
		InputBox, pass, Введите пароль, Введите пароль для установки защиты:,HIDE,250,130
		Sh= "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" output "%dir%\%name%-secured.pdf" owner_pw %pass%
		WaitProgress(1)
		RunWait, %comspec% /c %CmdLog% && %Sh% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
		WaitProgress(0, %A_LastError%, %ErrorLevel%)
		ControlClick, JPG,Конвертер, , LEFT
		return
	}
	IfMsgBox No
	{
		Gui 9:Submit
		FileSelectFile, files,3,,Защита PDF, Изображения (*.pdf)
		if files =
			return
		SplitPath, files,, dir,,name
		InputBox, pass, Введите пароль, Введите пароль для снятия защиты:,HIDE,250,130
		DeSh= "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" input_pw %pass% output "%dir%\%name%-norm.pdf"
		WaitProgress(1)
		RunWait, %comspec% /c %CmdLog% && %DeSh% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
		WaitProgress(0, %A_LastError%, %ErrorLevel%)
		ControlClick, JPG,Конвертер, , LEFT
		return
	}
	else
		return
}
return

Vost:
{
FileSelectFile, files,3,,Восстановление поврежденного PDF, Изображения (*.pdf)
if files =
    return
SplitPath, files,, dir,,name
}
fix= "%A_Temp%\DBFFC.tmp\pdftk.exe" "%files%" output "%dir%\%name%-Fixed.pdf"
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %fix% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

10ButtonОтмена:
Gui 10:Submit
9ButtonОтмена:
Gui 9:Submit
8ButtonОтмена:
Gui 8:Submit 
return
;===============================Сжатие Tiff=========================================================
ZT:
gosub, allguicancel
FileSelectFile, files, 3,,Сжатие TIFF, Изображения (*.tiff; *.tif)
if files =
    return
WinWaitClose Сжатие TIFF

OnMessage(0x3, "funczt")
OnMessage(0x112, "funczt")

DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	if i := !i
		Gui, 7:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h 105"
   DllCall("AnimateWindow", Ptr, hGui7, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
return

7ButtonOK:
GuiControlGet, Del
GuiControlGet, Zip
Gui 12:Submit

If del = 1
    conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -D -c 5 -q %Zip% -multi -o
else
	conv = "%A_Temp%\DBFFC.tmp\%cv%" -out tiff -c 5 -q %Zip% -multi -o

SplitPath, files,, dir,,name
conv = %conv% "%dir%\%name%-#.tiff" "%files%"

Gui 7:Submit
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
Return	

7ButtonОтмена:
Gui 7:Submit 
return
;===============================Конвертирование DOC файлов==========================================
DOC:
DnDDoc = ""
BDOC:
gosub, allguicancel
VarSetCapacity(WI, 64)
OnMessage(0x3, "funcdoc")
OnMessage(0x112, "funcdoc")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 11:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h100 w300"
   DllCall("AnimateWindow", Ptr, hGui11, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return

11ButtonHtml:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:HTML /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:HTML /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

11ButtonRtf:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:RTF /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:RTF /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

11ButtonMht:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:MHT /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:MHT /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

Txt:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:TXT /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:TXT /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

Xml:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:XML /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:XML /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

Pdf:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:PDF /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:PDF /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

Xps:
Gui 11:Submit
If DnDDoc = ""
{
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /F:XPS /v
}
else
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /F:XPS /v
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
return

Fb2:
Gui 11:Submit
If DnDDoc = ""
{ 
	FileSelectFile, files, 3,,Конвертирование документов, Поддерживаемые форматы (*.doc; *.docx; *.rtf; *.html; *.xml (WordML); *.mht; *.txt)
	if files =
		return
	WinWaitClose Конвертирование документов
	SplitPath, files,, dir,,name
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%files%" /f:fb2 /E:1251 /XSL:"%A_Temp%\DBFFC.tmp\doc2fb.xsl" /v
}
else
{
	SplitPath, DnDDoc,, Dir, Ext, Name
	doc = "%A_Temp%\DBFFC.tmp\doc.bat" "%DnDDoc%" /f:fb2 /E:1251 /XSL:"%A_Temp%\DBFFC.tmp\doc2fb.xsl" /v
}

WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %doc% >>"%LogPath%`%date`%.log" 2>>&1, , Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
return

Otm:
Gui 11:Submit
return
;===================================================================================================
;===================================================================================================
allguicancel:
{
	gui, 9:Submit
	gui, 11:Submit
	gui, 12:Submit
	gui, 13:Submit
	gui, 14:Submit
	gui, 21:Submit
	gui, 22:Submit
	gui, 23:Submit
	gui, 24:Submit
	gui, 25:Submit
	Gui, 27:submit
	return
}
;===================================================================================================
;================================FUNNCTION/=========================================================
GuiEscape:
MsgBox, 308, Завершение работы, Вы точно хотите закрыть программу?
IfMsgBox Yes
	ExitApp
Return

TEX:
GuiClose:
ButtonВыход:
GEX:
FileRemoveDir, %A_Temp%\DBFFC.tmp, 1

ExitApp