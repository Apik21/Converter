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

global GuiNum := % GuHi[2].GuiN
global GuiHigh := % GuHi[2].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h" GuiHigh
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x00010008))
Gui 12:Show, hide 
Return

2ButtonOK:
try {
GuiControlGet, del
GuiControlGet, Zip
Gui, 12:Submit
If del = 1
	conv = "%A_WorkingDir%\Sourse\%cv%" -out pdf -D -c 5 -q %Zip% -multi -o
else
    conv = "%A_WorkingDir%\Sourse\%cv%" -out pdf -c 5 -q %Zip% -multi -o
	
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
} catch e {
	MsgBox % e "ERROR code 1010 JP_Module"
}
Return

2ButtonОтмена:
Gui 2:Submit 
Return
;==========================Конвертирование Jpg to Ps================================================
JPs:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to PS, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Ps
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o
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
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ps" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,, Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1011 JPs_Module"
}
return
;==========================Конвертирование Jpg to Png================================================
JPn:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to PNG, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Png
	conv = "%A_WorkingDir%\Sourse\%cv%" -out png -c 5 -o
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
	conv = "%A_WorkingDir%\Sourse\%cv%" -out png -c 5 -o "%Dir%\%Name%.png" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1012 JPn_Module"
}
return
;==========================Конвертирование Jpg to Jpeg================================================
JJ:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to JPEG, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Jpeg
	conv = "%A_WorkingDir%\Sourse\%cv%" -out jpeg -c 5 -o
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
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o "%Dir%\%Name%.jpeg" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1013 JJ_Module"
}
return
;==========================Конвертирование Jpg to Ico================================================
JI:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to ICO, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to Ico
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ico -c 5 -o
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
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o "%Dir%\%Name%.ico" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1014 JI_Module"
}
return
;==========================Конвертирование Jpg to Emf================================================
JE:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to EMF, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to EMF
	conv = "%A_WorkingDir%\Sourse\%cv%" -out emf -c 5 -o
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path := A_LoopField
			conv = %conv% "%path%\`%.emf" "
		}
		else
			conv .= path "\" A_LoopField """ """ 
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o "%Dir%\%Name%.emf" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1015 JE_Module"
}
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
global GuiNum := % GuHi[4].GuiN
global GuiHigh := % GuHi[4].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	Gui, 4:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h" GuiHigh
	DllCall("AnimateWindow", Ptr, hGui4, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
Gui 12:Show, hide 
return
	
4ButtonOK:
try {
Gui, 12:Submit
GuiControlGet, Del
GuiControlGet, Zip
Gui, 4:Submit
conv = ""
If del = 1
    conv = "%A_WorkingDir%\Sourse\%cv%" -out tiff -D -c 5 -q %Zip% -multi -o
else
	conv = "%A_WorkingDir%\Sourse\%cv%" -out tiff -c 5 -q %Zip% -multi -o
IF DnDJpeg = ""
{
	Loop, parse, files, `n
	{
		if a_index = 1
		{
			path := A_LoopField
			conv = %conv% "%path%\`%.tiff" "
		}
		else
			conv .= path "\" A_LoopField """ """ 
	}
	StringTrimRight, conv, conv, 2
}
else
{
	SplitPath, DnDJpeg,, Dir, Ext, Name
	conv = %conv% "%Dir%\%Name%.tiff" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1016 JT_Module"
}
Return	

4ButtonОтмена:
Gui 4:Submit 
return
;==========================Конвертирование Jpg to Bmp================================================
JB:
try {
Gui, 12:Submit
IF DnDJpeg = ""
{
	FileSelectFile, files, M3,,Конвертация JPG to BMP, Изображения (*.jpg; *.jpeg) ; M3 = Множественный выбор существующих файлов.
	if files =
		return
	WinWaitClose Конвертация JPG to BMP
	conv = "%A_WorkingDir%\Sourse\%cv%" -out bmp -c 5 -o
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
	conv = "%A_WorkingDir%\Sourse\%cv%" -out ps -c 5 -o "%Dir%\%Name%.bmp" "%DnDJpeg%"
}
WaitProgress(1)
RunWait, %comspec% /c %CmdLog% && %conv% >>"%LogPath%`%date`%.log" 2>>&1,,Hide UseErrorLevel
WaitProgress(0, %A_LastError%, %ErrorLevel%)
ControlClick, JPG,Конвертер, , LEFT
} catch e {
	MsgBox % e "ERROR code 1017 JB_Module"
}
return
;=========================================================================================================