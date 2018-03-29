;~ ********************************************************************************************
;~ *******************************главное окно выбора действий*********************************
;~ ********************************************************************************************

GConvFile:
gosub, GExit
global GuiNum = 5
global PrevNum = 2
global Ext, Dir, Name
loop, 18
	GuiControl, %GuiNum%:Disable, % h_Ext%A_Index%
if ( Ext = "jpg" || Ext = "jpeg" ) {
	loop 
	{
		if A_Index in 3,4,5,6,7,8,11
			GuiControl, %GuiNum%:Enable, % h_Ext%A_Index%
		else if A_Index > 11
			break
	}
} Else if (Ext = "pdf") {
	loop 
	{
		if A_Index in 1,2,8,9,10,17
			GuiControl, %GuiNum%:Enable, % h_Ext%A_Index%
		else if A_Index > 17
			break
	}
} Else if (Ext = "tif" || Ext = "tiff") {
	loop 
	{
		if A_Index in 1,2,3,4,5,6,7,11
			GuiControl, %GuiNum%:Enable, % h_Ext%A_Index%
		else if A_Index > 11
			break
	}
} Else if (Ext = "png") {
	loop 
	{
		if A_Index in 1,2,3,4,5,6,7,8,11
			GuiControl, %GuiNum%:Enable, % h_Ext%A_Index%
		else if A_Index > 11
			break
	}
} Else if (Ext = "doc" || Ext = "docx") {
	loop 
	{
		if A_Index in 11,12,13,14,15,16,17,18
			GuiControl, %GuiNum%:Enable, % h_Ext%A_Index%
		else if A_Index > 18
			break
	}
}
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return
;~ **********************************************************************************************************
GZipFile:
gosub, GExit
global GuiNum = 9
global PrevNum = 2
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return
;~ ******************************************************************************************************
GProtectFile:
gosub, GExit
global GuiNum = 4
global PrevNum = 2
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return
;~ ****************************************************************************************************************
GProperFile:
gosub, GExit
global GuiNum = 3
global PrevNum := 2
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return
;~ ******************************************************************************************************************
GEditPDF:
gosub, GExit
global GuiNum = 6
global PrevNum = 2
GuiControl, %GuiNum%:Disable, % h_Merge
if coolFiles > 1
	GuiControl, %GuiNum%:Enable, % h_Merge
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return

;~ ********************************************************************************************
;~ *******************************Редактор свойств даты****************************************
;~ ********************************************************************************************

VI:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
GuiControlGet, Vremya,, hVremya, Vremya
if coolIFiles = 1
	FileSetTime, %Vremya%, %OneFile%, M
else {
	Loop, parse, AreaFile, `n 
		FileSetTime, %Vremya%, %A_LoopField%, M
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

VS:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
GuiControlGet, Vremya,, hVremya, Vremya
if coolIFiles = 1
	FileSetTime, %Vremya%, %OneFile%, C
else {
	Loop, parse, AreaFile, `n 
		FileSetTime, %Vremya%, %A_LoopField%, C
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

VD:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
GuiControlGet, Vremya,, hVremya, Vremya
if coolIFiles = 1
	FileSetTime, %Vremya%, %OneFile%, A
else {
	Loop, parse, AreaFile, `n 
		FileSetTime, %Vremya%, %A_LoopField%, A
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

;~ ********************************************************************************************
;~ *******************************Защита шифрованием*******************************************
;~ ********************************************************************************************

BasE:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
GuiControlGet, IntNum
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir, Ext, Name
	code = "%A_WorkingDir%\bin\bsed.exe" -e "%OneFile%" "%A_Temp%\DBFFC.tmp\%FiNam%"
	
	Loop %IntNum%
	{
		RunWait, %comspec% /c "%code%" ,, Hide UseErrorLevel
		FileDelete, "%OneFile%"
		sleep 1000
		FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
		sleep 1000
	}
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir
		code = "%A_WorkingDir%\bin\bsed.exe" -e "%A_LoopField%" "%A_Temp%\DBFFC.tmp\%FiNam%"
		Loop %IntNum%
		{
			RunWait, %comspec% /c "%code%" ,, Hide UseErrorLevel
			FileDelete, "%OneFile%"
			sleep 1000
			FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
			sleep 1000
		}
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

BasD:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
GuiControlGet, IntNum
global OneFile
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir, Ext, Name
	code = "%A_WorkingDir%\bin\bsed.exe" -d "%OneFile%" "%A_Temp%\DBFFC.tmp\%FiNam%"
	Loop %IntNum%
	{
		RunWait, %comspec% /c "%code%" ,, Hide UseErrorLevel
		FileDelete, "%OneFile%"
		sleep 1000
		FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
		sleep 1000
	}
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir
		code = "%A_WorkingDir%\bin\bsed.exe" -d "%A_LoopField%" "%A_Temp%\DBFFC.tmp\%FiNam%"
		Loop %IntNum%
		{
			RunWait, %comspec% /c "%code%" ,, Hide UseErrorLevel
			FileDelete, "%OneFile%"
			sleep 1000
			FileMove, %A_Temp%\DBFFC.tmp\%FiNam%, %dir%, 1
			sleep 1000
		}
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x0000) ; 0xA2EEA9 - зеленый, F97B71 - красный
return
;~ ********************************************************************************************
;~ *******************************Редактирование PDF*******************************************
;~ ********************************************************************************************
MergePdfFile:
SetControlColor(h_GB, 0x1010F1, 0x000000) ; Начало операции
merge = "%A_WorkingDir%\bin\%gs%" -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -sDEVICE=pdfwrite -sOutputFile=

Loop, parse, AreaFile, `n
{
	SplitPath, A_LoopField,, Dir,, Name
    if (a_index = 1)
	{
		temp = %merge%"%Dir%\%Name%_new.pdf"
		merge = %temp% "%A_LoopField%"
	}
	else
		merge = %merge% "%A_LoopField%"
}
RunWait, %comspec% /c %CodePage% && %merge%,, Hide UseErrorLevel
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; Конец операции
return

SavePdfPage:
gosub, GExit
global GuiNum = 8
global PrevNum = 6
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return

ProtectPdfFile:
gosub, GExit
global GuiNum = 7
global PrevNum = 6
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return

EProtectPdf:
pass := "", Sh := ""
InputBox, pass, Введите пароль, Введите пароль для установки защиты:,HIDE,250,130
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir,, Name
	Sh= "%A_WorkingDir%\bin\pdftk.exe" "%OneFile%" output "%Dir%\%Name%-Lock.pdf" owner_pw %pass%
	RunWait, %comspec% /c "%Sh%" ,, Hide UseErrorLevel
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir,, Name
		Sh= "%A_WorkingDir%\bin\pdftk.exe" "%A_LoopField%" output "%Dir%\%Name%-Lock.pdf" owner_pw %pass%
		RunWait, %comspec% /c "%Sh%" ,, Hide UseErrorLevel
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

DProtectPdf:
pass := "", DeSh := ""
InputBox, pass, Введите пароль, Введите пароль для снятия защиты:,HIDE,250,130
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir,, Name
	DeSh= "%A_WorkingDir%\bin\pdftk.exe" "%OneFile%" input_pw %pass% output "%Dir%\%Name%-Unlock.pdf"
	RunWait, %comspec% /c "%DeSh%" ,, Hide UseErrorLevel
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir,, Name
		DeSh= "%A_WorkingDir%\bin\pdftk.exe" "%A_LoopField%" input_pw %pass% output "%Dir%\%Name%-Unlock.pdf"
		RunWait, %comspec% /c "%DeSh%" ,, Hide UseErrorLevel
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

Prev:
gosub, GExit
Gui, %GuiNum%:Submit
if GuiNum = %PrevNum%
	PrevNum = 2
global GuiNum := PrevNum
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; выдвигаем/задвигаем окно-слайдер
Gui, %GuiNum%:Default
return

FixPdfFile:
global OneFile
global AreaFile
SetControlColor(h_GB, 0x1010F1, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir,, Name
	fix= "%A_WorkingDir%\bin\pdftk.exe" "%OneFile%" output "%Dir%\%Name%-Fixed.pdf"
	RunWait, %comspec% /c "%fix%" ,, Hide UseErrorLevel
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir,, Name
		fix= "%A_WorkingDir%\bin\pdftk.exe" "%A_LoopField%" output "%Dir%\%Name%-Fixed.pdf"
		RunWait, %comspec% /c "%fix%" ,, Hide UseErrorLevel
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный
return

Splt:
GuiControlGet, Stran
Value1 := ". " , Value2 := ", " , Value3 := "/ "
Value4 := "."  , Value5 := ","  , Value6 := "/"
Loop, 6 {
	N := A_Index - 1
	If A_Index = 1
		StringReplace, Stran%A_Index%, Stran, % Value%A_Index%, %A_Space%, All
	else
		StringReplace, Stran%A_Index%, % Stran%N%, % Value%A_Index%, %A_Space%, All
}

SetControlColor(h_GB, 0x1010F1, 0x000000) ; Начало операции
if (coolFiles = 1) {
	SplitPath, OneFile, FiNam, Dir,, Name
	split= "%A_WorkingDir%\bin\pdftk.exe" "%OneFile%" cat %Stran6% output "%Dir%\%Name%_new.pdf"
	RunWait, %comspec% /c "%split%" ,, Hide UseErrorLevel
} else {
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField, FiNam, Dir,, Name
		split= "%A_WorkingDir%\bin\pdftk.exe" "%A_LoopField%" cat %Stran6% output "%Dir%\%Name%_new.pdf"
		RunWait, %comspec% /c "%split%" ,, Hide UseErrorLevel
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; Конец операции
return

;~ ********************************************************************************************
;~ *******************************Сжатие файлов************************************************
;~ ********************************************************************************************
RunZipFile:
GuiControlGet, Qualily
GuiControlGet, DelStatus
Gui 9:Submit
if (coolFiles = 1) { 					 ; Если передан один файл
SetControlColor(h_GB, 0x1010F1, 0x000000) ; Начало операции
	SplitPath, OneFile,, Dir, Ext, Name
	If Ext in jpg,jpeg,JPG,JPEG
	{
		zipped = "%A_WorkingDir%\bin\%cv%" -out jpeg -c 8 -q %Quality% -multi -o "%Dir%\%Name%_zip.jpg" "%OneFile%"
		RunWait, %comspec% /c %CodePage% && %zipped%,, Hide UseErrorLevel
		If (DelStatus = 1) {
			FileSetAttrib, -R, %OneFile%
			FileDelete, %OneFile%
			sleep 500
		}
	}
	else if Ext in pdf,PDF
	{
		FileCreateDir, %A_Temp%\DBFFC.tmp\ZipPdfFile
		export = "%A_WorkingDir%\bin\%gs%" -sDEVICE=jpeg -dNOPAUSE -r150 -sOutputFile="%A_Temp%\DBFFC.tmp\ZipPdfFile\%Name%`%02d.jpg" "%OneFile%" -c quit
		zipped = "%A_WorkingDir%\bin\%cv%" -out pdf -D -c 5 -q %Quality% -multi -o "%Dir%\%Name%_zip.pdf" "%A_Temp%\DBFFC.tmp\ZipPdfFile\*.jpg"
		RunWait, %comspec% /c %CodePage% && %export%,, Hide UseErrorLevel
		RunWait, %comspec% /c %CodePage% && %zipped%,, Hide UseErrorLevel
		FileRemoveDir, %A_Temp%\DBFFC.tmp\ZipPdfFile, 1
		If (DelStatus = 1) {
			FileSetAttrib, -R, %OneFile%
			FileDelete, %OneFile%
			sleep 500
		}
	}
	else if Ext in tiff,tif
	{
		zipped = "%A_WorkingDir%\bin\%cv%" -out tiff -c 5 -q %Quality% -multi -o "%Dir%\%Name%_zip.tiff" "%OneFile%"
		RunWait, %comspec% /c %CodePageg% && %zipped%,, Hide UseErrorLevel
		If (DelStatus = 1) {
			FileSetAttrib, -R, %OneFile%
			FileDelete, %OneFile%
			sleep 500
		}
	}
} else {                  ; Если передано более одного файла
	Loop, parse, AreaFile, `n
	{
		SplitPath, A_LoopField,, Dir,Ext, Name
		If Ext in jpg,jpeg,JPG,JPEG
		{
			zipped = "%A_WorkingDir%\bin\%cv%" -out jpeg -c 8 -q %Quality% -multi -o "%Dir%\%Name%_zip.jpg" "%A_LoopField%"
			RunWait, %comspec% /c %CodePage% && %zipped%,, Hide UseErrorLevel
			If (DelStatus = 1) {
				FileSetAttrib, -R, %A_LoopField%
				FileDelete, %A_LoopField%
				sleep 500
			}
		}
		else if Ext in pdf,PDF
		{
			FileCreateDir, %A_Temp%\DBFFC.tmp\ZipPdfFile
			export = "%A_WorkingDir%\bin\%gs%" -sDEVICE=jpeg -dNOPAUSE -r150 -sOutputFile="%A_Temp%\DBFFC.tmp\ZipPdfFile\%Name%`%02d.jpg" "%A_LoopField%" -c quit
			zipped = "%A_WorkingDir%\bin\%cv%" -out pdf -D -c 5 -q %Quality% -multi -o "%Dir%\%Name%_zip.pdf" "%A_Temp%\DBFFC.tmp\ZipPdfFile\*.jpg"
			RunWait, %comspec% /c %CodePage% && %export%,, Hide UseErrorLevel
			RunWait, %comspec% /c %CodePage% && %zipped%,, Hide UseErrorLevel
			FileRemoveDir, %A_Temp%\DBFFC.tmp\ZipPdfFile, 1
			If (DelStatus = 1) {
				FileSetAttrib, -R, %A_LoopField%
				FileDelete, %A_LoopField%
				sleep 500
			}
		}
		else if Ext in tiff,tif
		{
			zipped = "%A_WorkingDir%\bin\%cv%" -out tiff -c 5 -q %Quality% -multi -o "%Dir%\%Name%_zip.tiff" "%A_LoopField%"
			RunWait, %comspec% /c %CodePageg% && %zipped%,, Hide UseErrorLevel
			If (DelStatus = 1) {
				FileSetAttrib, -R, %A_LoopField%
				FileDelete, %A_LoopField%
				sleep 500
			}
		}
	}
}
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; Конец операции
return

;~ ********************************************************************************************
;~ *******************************Конвертирование JPG******************************************
;~ ********************************************************************************************