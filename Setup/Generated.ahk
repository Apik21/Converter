#NoEnv          ; для производительности и совместимости с будущими AutoHotkey-релизы.
#Persistent     ; Выполнять скрипт, пока не закроет пользователь.
#IfWinActive, ahk_class AutoHotkeyGUI ;работает только в активном GUI, при сворачивании ожидает активации окна.
#SingleInstance Force ; старый экземпляр скрипта будет замещён новым автоматически, без вывода диалогового окна.
#Include Functions.ahk


SendMode Input  ; для новых сценариев, обеспечение высокой скорости и надежности.
SetWorkingDir %A_ScriptDir%  ; Обеспечивает согласованность c начальныv каталогом.
FileCreateDir, %A_Temp%\DBFFC.tmp
FileCreateDir, %A_AppData%\Конвертер\Logs

;***********************************************************************************************
pr:= a_scriptdir . "\SkinH_EL.dll"
IniRead, aa1, %A_WorkingDir%\Config.ini , Skin , SkinPath
aa1:= aa1
SkinForm(Apply,pr,aa1)
OnExit, GuiClose
try {
	Skins =
	Loop, %A_WorkingDir%\she\*.she
		Skins .= A_LoopFileName "|"
} catch e {
	MsgBox % e "ERROR Code 1018 Skins_Read"
}
		
;***********************************************************************************************

global Vers, global sborka, global dev_sborka
global DnDJpeg, global DnDPdf, global DnDTiff, global DnDDoc, global DnDPng, global PageN
global LogLine, global CmdLog
global gs, global cv, global sys
Global Win, global Dos, global Iso, global Koir, global Koiu, global Mac, global Period

;***************Проверка разрядности системы************************************************************
Architectura()
if (sys = "win64")
{
	gs := "gswin64c.exe"
	cv := "cvert64.exe"
}
else if (sys = "win32")
{
	gs := "gswin32c.exe"
	cv := "cvert.exe"
}
;***********************************************************************************************
;***************Переменные настройки************************************************************
;***********************************************************************************************
sborka = 1                                  ; Номер сборки версии
dev_sborka = https://raw.githubusercontent.com/Apik21/Converter/setup/sborka.txt ;Сборка с сайта
Vers = v1.1.3								  ; Номер версисии комбайна
PageN = 1251                                  ; Номер кодовой страницы
Repo = https://raw.githubusercontent.com/Apik21/Converter/setup_113/ConverterSetup.exe ; Адрес программы для обновления
Rep = https://github.com/Apik21/Converter/tree/setup_113
LogPath = %A_AppData%\Конвертер\Logs\         ; Путь к папле для создания логов
LogLine = "=========================================== `%date`% - `%time`% ================================================"
CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
;***********************************************************************************************
;***********************************************************************************************
;***********************************************************************************************
IfExist %A_Temp%\*.*
	FileDelete, %A_Temp%\*.*
;***********************************************************************************************
IfNotExist, %A_WorkingDir%\Config.ini
{
	IniWrite, 1251, %A_WorkingDir%\Config.ini, Options, PageN
	IniWrite, 14, %A_WorkingDir%\Config.ini, Options, Period
	IniWrite, %A_YDay%, %A_WorkingDir%\Config.ini, Options, DataIzm
	global PageN = 1251, global Period = 14
   	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	RunWait, %comspec% /c %CmdLog%,, Hide UseErrorLevel
	GuiControl,27:,Period, %Period% 
	IniWrite, %A_WorkingDir%\she\aero.she, %A_WorkingDir%\Config.ini, Skin, SkinPath
}
else
{
	IniRead, PageN, %A_WorkingDir%\Config.ini, Options, PageN, 1251
	CmdLog = echo %LogLine% >>"%LogPath%`%date`%.log" 2>>&1 && chcp %PageN% >>"%LogPath%`%date`%.log" 2>>&1
	RunWait, %comspec% /c %CmdLog%,, Hide UseErrorLevel
	IniRead, Period, %A_WorkingDir%\Config.ini, Options, Period, 14
	GuiControl,27:, Period, %Period%
}
;***********************************************************************************************
;================================GUI/===============================================================
Gui, +hwndhGui1 + OwnDialogs +lastfound
Menu, Option, Add, &Открыть логи, LogOpen
Menu, Option, Add, &Настройки, Options
Menu, Option, Add, О&бновление, Update
Menu, HelpMenu, Add, &Справка, HelpAbout
Menu, HelpMenu, Add, &ChangeLog, Changelog
Menu, MyMenuBar, Add, Параметры, :Option
Menu, MyMenuBar, Add, Справка (F1), :HelpMenu ; Создаем строку меню, присоединяя к ней подменю:


Menu, Tray, NoStandard
Menu, Tray, MainWindow
;~ Menu, pConvert, add, Jpg->Pdf, JP
;~ Menu, pConvert, add, Pdf->Jpg, PJ
;~ Menu, pConvert, add, Jpg->Tiff, JT
;~ Menu, pConvert, add, Tiff->Jpg, TJ
;~ Menu, pZip, add, JPG, ZJ
;~ Menu, pZip, add, PDF, ZP
;~ Menu, pZip, add, TIFF, ZT
;~ Menu, Tray, add, Конвертация, :pConvert
;~ Menu, Tray, add, Сжатие, :pZip
Menu, Tray, add
Menu, Tray, add, Закрыть, GuiClose
Menu, Tray, Tip, Ковертер изображений
Gui, Menu, MyMenuBar ; Присоединяем строку меню к окну:

Gui, Add, GroupBox, x2 y10 w340 h100 cRed, Форматы
Gui, Add, Button, x12 y30 w100 h30 , JPG
Gui, Add, Button, x122 y30 w100 h30 , TIFF
Gui, Add, Button, x232 y30 w100 h30 , DOC
Gui, Add, Button, x12 y70 w100 h30 , PDF
Gui, Add, Button, x122 y70 w100 h30 , PNG
Gui, Add, Button, x232 y70 w100 h30 , DJVU
Gui, Add, GroupBox, x4 y118 w340 h83 cRed, Обработка
Gui, Add, Button, x50 y137 w110 h40 , Изменить атрибуты даты файлов
Gui, Add, Button, x190 y137 w110 h40 , Шифрование
Gui, Add, Progress, x12 y220 w320 h20 Smooth vProgr
Gui, Add, Button, x125 y270 w100 h30 gGuiClose, Выход
Gui, Add, StatusBar,,
SB_SetParts(150, 110)
SB_SetText("Версия " . Vers . "." . sborka, 2)
SB_SetText(	A_Hour . ":" . A_Min, 3)
SetTimer, BarTime, 3000
SB_SetIcon("shell32.dll", 266)
Gui, Default

{
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

Gui, 26:+hwndhGui26 +owner1 -Caption +Border
Gui, 26:Add, Button, x5 y5 w100 h30 gDnd_Zip, Пакетное сжатие
Gui, 26:Add, Button, xp+105 yp w100 h30 gDnd_Merge, Склеить выбранное
Gui, 26:Add, Button, xp+105 yp w80 h30 gDnd_Cancel, Отмена

Gui, 27:Add, GroupBox, x3 y10 w150 h180 , Кодовая страница
Gui, 27:Add, ListBox, vPageCode x15 y46 Choose1 R6 h150 AltSubmit, 1251     - Windows|866       - Dos|28595   - ISO|20866   - KOI8-R|21866   - KOI8-U|10007   - Mac
Gui, 27:Add, GroupBox, x162 y10 w252 h115 , Обновление
Gui, 27:Add, Text, x170 y35 w150 h20 , Проверка обновлений
Gui, 27:Add, Edit, x170 y56 w227 h20 vRep, %Rep%
Gui, 27:Add, Text, x170 y80 w200 h20 , Частота автопроверки обновлений
Gui, 27:Add, Edit, x170 y101 w30 h20 vPeriod, %Period%
Gui, 27:Add, Text, x210 y101 w50 h20 , дней
Gui, 27:Add, GroupBox, x162 y130 w252 h60 , Оформление
Gui, 27:Add, Text, x167 yp+25 w40  , Скин
Gui, 27:Add, DropDownList, xp+45 yp w190 vSkinName Sort, %Skins%
Gui, 27:Add, Button, x100 y210 w100 h30 , Сохранить
Gui, 27:Add, Button, xp+150 yp w100 h30 , Отмена
}

VarSetCapacity(WI, 64)
Sleep, 1024

global Arr := [{Perem: "Win",  Page: 1251,  Chek: "- 1251 Win"}
			 , {Perem: "Dos",  Page: 866,   Chek: "- 866 Dos"}
			 , {Perem: "Iso",  Page: 28595, Chek: "- 28595 ISO"}
			 , {Perem: "Koir", Page: 20866, Chek: "- 20866 KOI8-R"}
			 , {Perem: "Koiu", Page: 21866, Chek: "- 21866 KOI8-U"}
			 , {Perem: "Mac",  Page: 10007, Chek: "- 10007 Mac"}]


global GuHi := [{GuiN: 1,  Hg: 190}
			 , {GuiN: 2,  Hg: 105}	
			 , {GuiN: 3,  Hg: 70}
			 , {GuiN: 4,  Hg: 105}			 
			 , {GuiN: 5,  Hg: 115}
			 , {GuiN: 6,  Hg: 105}
			 , {GuiN: 7,  Hg: 105}
			 , {GuiN: 8,  Hg: 105}
			 , {GuiN: 9,  Hg: 80}
			 , {GuiN: 10, Hg: 115}
			 , {GuiN: 11, Hg: 100}
			 , {GuiN: 12, Hg: 85}
			 , {GuiN: 13, Hg: 90}
			 , {GuiN: 14, Hg: 85}
			 , {GuiN: 15, Hg: 115}
			 , {GuiN: 16, Hg: 115}
			 , {GuiN: 17, Hg: 115}
			 , {GuiN: 18, Hg: 115}
			 , {GuiN: 19, Hg: 115}
			 , {GuiN: 20, Hg: 115}
			 , {GuiN: 21, Hg: 140}
			 , {GuiN: 22, Hg: 85}
			 , {GuiN: 23, Hg: 105}
			 , {GuiN: 24, Hg: 105}
			 , {GuiN: 25, Hg: 100}
			 , {GuiN: 26, Hg: 40}]
			 
Gui, Show, Center h330 w350, Конвертер 1.1.3.1beta

Return

BarTime:
SB_SetText(A_Hour . ":" . A_Min, 3)
return

Changelog:
MsgBox, 64, CHANGELOG, #CHANGELOG`nИзменения сборки 1.`n`nФУНКЦИЯ Drag and Drop:`n- Добавлено пакетное сжатие jpg`, pdf и tiff файлов`;`n- При перенесении нескольких файлов jpg`, tiff или pdf появляются варианты действий сжать/склеить`;`n- При выборе склеить pdf и tiff слеивается в один файл`, а jpg конвертируеся в многостраничный pdf.`n`nМЕНЮ`n- В меню Справка добавлен ChangeLog используемой сборки.`n`nПРОЧЕЕ`n- Добавлена поддержка скинов оформления рабочего окна в меню параметры.
return

F1::
HelpAbout:
Run, "%A_WorkingDir%\Help\1.chm"
return

LogOpen:
Run, "%LogPath%"
return

Update:
try {
IfExist, %A_Temp%\DBFFC.tmp\sborka.txt
	FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
If ConnectedToInternet()
{
	UrlDownloadToFile, %dev_sborka%, %A_Temp%\DBFFC.tmp\sborka.txt
	ELM(%ErrorLevel%, Ошибка загрузки, 1)
	FileRead, new_sborka, %A_Temp%\DBFFC.tmp\sborka.txt
	ELM(%ErrorLevel%, Ошибка чтения, 1)
	If new_sborka > %sborka%
	{
		MsgBox, 52, Обновление, Найдена новая версия программы.`n Текущая версия программы - %Vers%.%sborka%,`n Новая версия программы - %Vers%.%new_sborka%.`n Скачать обновление???
		FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
		IfMsgBox Yes
		{
			MsgBox,,Конвертер,Спасибо за ваш выбор.
			Run, %Repo%
			bat = ping 127.0.0.1 > NUL`ndel /F /Q Converter*.exe`ndel /F /Q delete.bat
			FileDelete, delete.bat
			FileAppend %bat%, delete.bat
			Run delete.bat, ,Hide
			ExitApp
		}
	}
	else
	{
		MsgBox,,Поздравляю!,Вы используете последнюю версию программы.
		FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
	}
}	
else 
{
	Msgbox, 48, Ошибка подключения, Нет подключения к Интернету. Обратитесь к администратору вашей сети!
}
} catch e {
	MsgBox "ERROR code 1004 UPD_module"
}
Return

Options:
return

GuiClose:
ExitApp