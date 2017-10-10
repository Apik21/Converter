#NoEnv          ; для производительности и совместимости с будущими AutoHotkey-релизы.
#Persistent     ; Выполнять скрипт, пока не закроет пользователь.
#IfWinActive, ahk_class AutoHotkeyGUI ;работает только в активном GUI, при сворачивании ожидает активации окна.
#SingleInstance Force ; старый экземпляр скрипта будет замещён новым автоматически, без вывода диалогового окна.

#Include Functions.ahk
#Include Data.ahk
#Include Base64.ahk
#Include GUI_Buttons.ahk
#Include Conv_JPG.ahk


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
	Skins = ==NO_SKIN== |
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
SB_SetText("Версия v" . Vers . "." . sborka, 2)
SB_SetText(	A_Hour . ":" . A_Min, 3)
SetTimer, BarTime, 3000
SB_SetIcon("shell32.dll", 266)
Gui, Default

{
Loop
{
	If A_Index  in 4,6,7,8,23,24
	{
		Gui, %A_Index%:+hwndhGui%A_Index% +owner1 -Caption +Border
		Gui, %A_Index%:Add, Edit, x5 y5 w60 h25 vZip , 85
		Gui, %A_Index%:Add, Text, x70 y5 w150 h30 r2 , Степень сжатия (качество)`n 1-max 99-min
		Gui, %A_Index%:Add, CheckBox, x5 y40 w150 h25 vDel, УДАЛИТЬ исходные файлы
		Gui, %A_Index%:Add, Button, x5 y70 w100 h30 , OK
		Gui, %A_Index%:Add, Button, x115 y70 w100 h30 , Отмена
	}
	If A_Index > 24
		break
}

Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 3:Add, CheckBox, x5 y5 w200 h25 vDel, УДАЛИТЬ исходные файлы
Gui, 3:Add, Button, x5 y40 w100 h30 , OK
Gui, 3:Add, Button, x115 y40 w100 h30 , Отмена

Loop
{
	If A_Index  in 15,16,17,18,19,20
	{
		Gui, %A_Index%:+hwndhGui%A_Index% +owner1 -Caption +Border
		Gui, %A_Index%:Add, Edit, x5 y5 w50 h20 vZip , 85
		Gui, %A_Index%:Add, Edit, x5 y35 w50 h20 vPage, 0
		Gui, %A_Index%:Add, Text, x70 y5 w210 h20 r2, Степень сжатия (качество) `n 1-max 99-min
		Gui, %A_Index%:Add, Text, x70 y35 w180 h25 , Номер конвертируемой страницы `n 0-все страницы
		Gui, %A_Index%:Add, CheckBox, x5 y60 w200 h20 vDel, УДАЛИТЬ исходные файлы
		Gui, %A_Index%:Add, Button, x5 y85 w100 h30 , OK
		Gui, %A_Index%:Add, Button, x115 y85 w100 h30 , Отмена
		}
	If A_Index > 24
		break
}

Gui, 9:+hwndhGui9 +owner1 -Caption +Border
Gui, 9:Add, Button, x2 y5 w80 h30 , Сжать
Gui, 9:Add, Button, x2 y40 w80 h30 gVost, Восстановить
Gui, 9:Add, Button, x84 y5 w80 h30 , Разрезать
Gui, 9:Add, Button, x84 y40 w80 h30 , Склеить
Gui, 9:Add, Button, x166 y5 w75 h30 gMD, Изм. Мета.
Gui, 9:Add, Button, x166 y40 w75 h30 gDSh, Защита

Gui, 10:+hwndhGui10 +owner1 -Caption +Border
Gui, 10:Add, Edit, x5 y10 w250 h25 vStran
Gui, 10:Add, Text, x5 y40 w290 h40, Укажите сохраняемые страницы:1, 3-5, 8 Для поворота после страницы указать сторну поворота: left, right, down. См. справку.
Gui, 10:Add, Button, x5 y85 w140 h30 gSplt, Сохранить выбранные страницы
Gui, 10:Add, Button, x150 y85 w140 h30 gSpltAll, Разобрать на страницы
Gui, 10:Add, Button, x230 y120 w60 h30 , Отмена

Gui, 11:+hwndhGui11 +owner1 -Caption +Border
Gui, 11:Add, Text, x10 y5 w290 h20 , В какой формат будем конвертировать документ?
Gui, 11:Add, Button, x5 y30 w60 h30 gCHtml, HTML
Gui, 11:Add, Button, x70 y30 w60 h30 gCRtf, RTF
Gui, 11:Add, Button, x135 y30 w60 h30 gCMht, MHT
Gui, 11:Add, Button, x200 y30 w60 h30 gCTxt, TXT
Gui, 11:Add, Button, x200 y65 w60 h30 gCXml, XML
Gui, 11:Add, Button, x135 y65 w60 h30 gCPdf, PDF
Gui, 11:Add, Button, x70 y65 w60 h30 gCXps, XPS
Gui, 11:Add, Button, x5 y65 w60 h30 gCFb2, FB2

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
			 , {GuiN: 10, Hg: 155}
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
			 , {GuiN: 26, Hg: 40}
			 , {GuiN: 27, Hg: 250}]

Gui, Show, Center h190 w300, Конвертер

;================АВТООБНОВЛЕНИЕ=====================================
try {
IfExist, %A_WorkingDir%\Config.ini
{
	IniRead, DataIzm, %A_WorkingDir%\Config.ini, Options, DataIzm
	Delta = %A_YDay% - %DataIzm%
	
	If Delta >= %Period%
	{
		IfExist, %A_Temp%\DBFFC.tmp\sborka.txt
		FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
		If ConnectedToInternet()
		{
			UrlDownloadToFile, %dev_sborka%, %A_Temp%\DBFFC.tmp\sborka.txt
			ELM(%ErrorLevel%, Ошибка загрузки, 1)
			FileRead, new_sborka, %A_Temp%\DBFFC.tmp\sborka.txt
			ELM(%ErrorLevel%, Ошибка чтения, 1)
			old_vers := Vers "." sborka
			StringReplace, old_versP, old_vers, .,, All
			StringReplace, new_sborkaP, new_sborka, .,, All
			If new_sborkaP > %old_versP%
			{
				MsgBox, 52, Обновление, Найдена новая версия программы.`n Текущая версия программы - %old_versP%,`n Новая версия программы - %new_sborkaP%.`n`n Скачать обновление???
				IfMsgBox Yes
				{
					MsgBox,,Конвертер,Спасибо за ваш выбор.
					Run, %Repo%
					bat = ping 127.0.0.1 > NUL`ndel /F /Q ConverterSetup*.exe`ndel /F /Q delete.bat
					FileDelete, delete.bat
					FileAppend %bat%, delete.bat
					Run delete.bat, ,Hide
					ExitApp
				}
				else
					FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
			}
			else
				FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
		}	
		else 
			Msgbox, 48, Ошибка подключения, Нет подключения к Интернету. Обратитесь к администратору вашей сети!
	}
}
} catch e {
	MsgBox % e "ERROR code 1007 AutoUpdate"
}
Return
;================================GUI\===============================================================
;~ GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y)
;~ {
	;~ If A_EventInfo = 1 
	;~ {
		;~ for i, Files in FileArray
		;~ {
		;~ try {
			;~ SplitPath, Files,, Dir, Ext, Name
	   ;~ ; Сжатие перетаскиваемых файлов
			;~ If (( Ext = "jpg" || Ext = "jpeg" ) && ( A_GuiControl = "T I F F" || A_GuiControl = "P D F" || A_GuiControl = "J P G" || A_GuiControl = " Сжатие" ))
			;~ {
				;~ conv = "%A_WorkingDir%\Sourse\%cv%" -out jpeg -c 8 -q 50 -multi -o "%Dir%\%Name%_zip.jpg" "%Files%"
				;~ WaitProgress(1)
				;~ RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				;~ WaitProgress(0, %A_LastError%, %ErrorLevel%)
			;~ }
			;~ else If (( Ext = "pdf" ) && ( A_GuiControl = "T I F F" || A_GuiControl = "P D F" || A_GuiControl = "J P G" || A_GuiControl = " Сжатие" ))
			;~ {
				;~ FileCreateDir, %A_Temp%\DBFFC.tmp\ZipPdfFile
				;~ export = "%A_WorkingDir%\Sourse\%gs%"  -sDEVICE=jpeg -dNOPAUSE -r150  -sOutputFile="%A_Temp%\DBFFC.tmp\ZipPdfFile\%Name%`%02d.jpg" "%Files%" -c quit
				;~ conv = "%A_WorkingDir%\Sourse\%cv%" -out pdf -D -c 5 -q 50 -multi -o "%dir%\%Name%_zip.pdf" "%A_Temp%\DBFFC.tmp\ZipPdfFile\*.jpg"
				;~ WaitProgress(1)
				;~ RunWait, %comspec% /c %CmdLog% && %export% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				;~ RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				;~ FileRemoveDir, %A_Temp%\DBFFC.tmp\ZipPdfFile, 1
				;~ WaitProgress(0, %A_LastError%, %ErrorLevel%)
			;~ } 
			;~ else if (( Ext = "tiff" || Ext = "tif" ) && ( A_GuiControl = "T I F F" || A_GuiControl = "P D F" || A_GuiControl = "J P G" || A_GuiControl = "Сжатие" ))
			;~ {
				;~ conv = "%A_WorkingDir%\Sourse\%cv%" -out tiff -c 5 -q 50 -multi -o "%Dir%\%Name%_#.tiff" "%Files%"
				;~ WaitProgress(1)
				;~ RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
				;~ WaitProgress(0, %A_LastError%, %ErrorLevel%)
			;~ }
			;~ ; Конвертирование перетаскиваемых файлов
			;~ else if (( Ext = "jpg" || Ext = "jpeg" ) && ( A_GuiControl = "TIFF" || A_GuiControl = "PDF" || A_GuiControl = "JPG" || A_GuiControl = "DOC" || A_GuiControl = "PNG" || A_GuiControl = "Конвертирование из" ))
			;~ {
				;~ DnDJpeg = %Files%
				;~ gosub, BJPG
			;~ }
			;~ else if (( Ext = "pdf" ) && ( A_GuiControl = "TIFF" || A_GuiControl = "PDF" || A_GuiControl = "JPG" || A_GuiControl = "DOC" || A_GuiControl = "PNG" ||A_GuiControl =  "Конвертирование из" ))
			;~ {
				;~ DnDPdf = %Files%
				;~ gosub, BPDF
			;~ }
			;~ else if (( Ext = "tiff" || Ext = "tif" ) && ( A_GuiControl = "TIFF" || A_GuiControl = "PDF" || A_GuiControl = "JPG" || A_GuiControl = "DOC" || A_GuiControl = "PNG" || A_GuiControl = "Конвертирование из"))
			;~ {
				;~ DnDTiff = %Files%
				;~ gosub, BTIFF
			;~ }
			;~ else if (( Ext = "doc" || Ext = "docx" || Ext = "html" || Ext = "xml" || Ext = "rtf" || Ext = "mht" || Ext = "txt" ) && (A_GuiControl = "TIFF" || A_GuiControl = "PDF" || A_GuiControl = "JPG" || A_GuiControl = "DOC" || A_GuiControl = "PNG" || A_GuiControl = "Конвертирование из"))
			;~ {
				;~ DnDDoc = %Files%
				;~ gosub, BDOC
			;~ }
			;~ else if (( Ext = "png" ) && (A_GuiControl = "TIFF" || A_GuiControl = "PDF" || A_GuiControl = "JPG" || A_GuiControl = "DOC" || A_GuiControl = "PNG" || A_GuiControl = "Конвертирование из"))
			;~ {
				;~ DnDPng = %Files%
				;~ gosub, BPNG
			;~ }
			;~ else 
			;~ {
				;~ MsgBox, 4148, Ошибка, Файлы перемещены не в блок обработки`, либо данный тип файлов не поддерживается. Открыть справку "Функция Drag-and-Drop"?
				;~ IfMsgBox Yes
					;~ Run, "%A_WorkingDir%\Sourse\1.chm"
				;~ else return
			;~ }
		;~ } catch e {
			;~ MsgBox % e "ERROR code 1001 DnD_General"
		;~ }
		;~ }
	;~ }
	
;~ If (A_EventInfo > 1)
	;~ {
		;~ try {
		;~ global FileList := A_GuiControlEvent 
		;~ Sort, FileList 
		;~ gosub, allguicancel
		;~ gosub, g26
		;~ return
	;~ } catch e {
		;~ MsgBox % e "ERROR code 1005 DnD_General_Event"
		;~ }
	;~ }
;~ Return	
;~ }

G26:
try {
	global GuiNum := % GuHi[26].GuiN
	global GuiHigh := % GuHi[26].Hg
	OnMessage(0x3, "FuncGui")
	OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
	DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	if i := !i
	{
		xI := NumGet(WI, 20, UInt)
		yI := NumGet(WI, 16, UInt)
		Gui, %GuiNum%:Show, x%xI% y%yI% h%GuiHigh% w300
	}
	DllCall("AnimateWindow", Ptr, hGui26, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
} catch e {
	MsgBox % e "ERROR code 1006 DnD_Gui26"
	}
return

Dnd_Cancel:
Gui 26:Submit
ControlClick, JPG,Конвертер, , LEFT
return

Dnd_Zip:
Gui 26:Submit
ControlClick, JPG,Конвертер, , LEFT
Loop, parse, FileList, `n
{
	try {
	Files := A_LoopField
	SplitPath, Files,, Dir, Ext, Name
	If Ext in jpg,jpeg,JPG,JPEG
	{
		conv = "%A_WorkingDir%\Sourse\%cv%" -out jpeg -c 8 -q 50 -multi -o "%Dir%\%Name%_zip.jpg" "%Files%"
		WaitProgress(1)
		RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
		WaitProgress(0)
	} 
	else if Ext in pdf,PDF
	{
		FileCreateDir, %A_Temp%\DBFFC.tmp\ZipPdfFile
		export = "%A_WorkingDir%\Sourse\%gs%" -sDEVICE=jpeg -dNOPAUSE -r150 -sOutputFile="%A_Temp%\DBFFC.tmp\ZipPdfFile\%Name%`%02d.jpg" "%Files%" -c quit
		conv = "%A_WorkingDir%\Sourse\%cv%" -out pdf -D -c 5 -q 50 -multi -o "%dir%\%Name%_zip.pdf" "%A_Temp%\DBFFC.tmp\ZipPdfFile\*.jpg"
		WaitProgress(1)
		RunWait, %comspec% /c %CmdLog% && %export% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
		RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
		FileRemoveDir, %A_Temp%\DBFFC.tmp\ZipPdfFile, 1
		WaitProgress(0)
	} 
	else if Ext in tiff,tif
	{
		conv = "%A_WorkingDir%\Sourse\%cv%" -out tiff -c 5 -q 50 -multi -o "%Dir%\%Name%_zip.tiff" "%Files%"
		WaitProgress(1)
		RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
		WaitProgress(0)
	}
	} catch e {
		MsgBox % e "ERROR code 1002 DnD_Zip"
	}
	
}
Return

Dnd_Merge:
{
Gui 26:Submit
ControlClick, JPG,Конвертер, , LEFT
try {
Loop, parse, FileList, `n
{
	Files := A_LoopField
	SplitPath, Files,, Dir, Ext, Name
	global mark := Ext
	Char = "
	Dnd_merge_files .=  A_Space Char Files Char
}

If mark in pdf,PDF
{
	merge = "%A_WorkingDir%\Sourse\%gs%" -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -sDEVICE=pdfwrite -sOutputFile="%Dir%\%Name%_#.pdf" %Dnd_merge_files%
	WaitProgress(1)
	RunWait, %comspec% /c %CmdLog% && %merge% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
	Dnd_merge_files :=
	mark :=
	WaitProgress(0)
}
else If mark in jpg,jpeg
{
	
	conv = "%A_WorkingDir%\Sourse\%cv%" -out pdf -c 5 -q 85 -multi -o "%Dir%\%Name%.pdf" %Dnd_merge_files%
	WaitProgress(1)
	RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
	Dnd_merge_files :=
	mark :=
	WaitProgress(0)
}
else If mark in tif,tiff
{
	conv = "%A_WorkingDir%\Sourse\%cv%" -out tiff -c 5 -q 85 -multi -o "%Dir%\%Name%_#.tiff" %Dnd_merge_files%
	WaitProgress(1)
	RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
	WaitProgress(0)
}
else MsgBox, "Тип файлов не поддерживается данной программой `nОбратитесь к разработчику для добавления нового типа файлов."
	
Dnd_merge_files := 
mark := 
} catch e {
	MsgBox % e "ERROR code 1003 DnD_Merge"
}
return
}


BarTime:
SB_SetText(A_Hour . ":" . A_Min, 3)
return

Changelog:
MsgBox, 64, CHANGELOG, #CHANGELOG`nИзменения сборки 1.1.3.1.`n`nИнтерфейс:`n- Полностью обновлен интерфейс программы`n`nРедактор PDF:`n- Добавлена функция сохранять все страницы документа отдельными файлами.
return

;================================MAIN/=========================================================

;***********************************************************************************************
;*****************************OPTIONS***********************************************************
;***********************************************************************************************

Options:
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
	old_vers := Vers "." sborka
	StringReplace, old_versP, old_vers, .,, All
	StringReplace, new_sborkaP, new_sborka, .,, All
	If new_sborkaP > %old_versP%
	{
		MsgBox, 52, Обновление, Найдена новая версия программы.`n Текущая версия программы - %old_vers%,`n Новая версия программы - %new_sborka% .`n`n Скачать обновление???
		IfMsgBox Yes
		{
			MsgBox,,Конвертер,Спасибо за ваш выбор.
			Run, %Repo%
			bat = ping 127.0.0.1 > NUL`ndel /F /Q ConverterSetup*.exe`ndel /F /Q delete.bat
			FileDelete, delete.bat
			FileAppend %bat%, delete.bat
			Run delete.bat, ,Hide
			ExitApp
		}
		else
			FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
	}
	else
	{
		MsgBox,,Поздравляю!,Вы используете последнюю версию программы.
		FileDelete, %A_Temp%\DBFFC.tmp\sborka.txt
	}
}	
else 
	Msgbox, 48, Ошибка подключения, Нет подключения к Интернету. Обратитесь к администратору вашей сети!
} catch e {
	MsgBox "ERROR code 1004 UPD_module"
}
Return

GuiClose:
ExitApp