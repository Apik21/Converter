;==========================Шифрование===============================================================
Bas:
allguicancel()
global GuiNum := % GuHi[25].GuiN
global GuiHigh := % GuHi[25].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h" GuiHigh " w300"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
Return
;===================================================================================================
BasE:
try {
Gui 25:Submit
FileSelectFile, files, 3,,Зашифровать файл, Все файлы (*.*)
if files =
	return
WinWaitClose Зашифровать файл
SplitPath, files, FiNam, Dir, Ext, Name
base = "%A_WorkingDir%\Sourse\bsed.exe" -e "%files%" "%A_Temp%\DBFFC.tmp\%FiNam%" 
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
} catch e {
	MsgBox % e "ERROR code 1008 BasE"
}
Return
;===================================================================================================
BasD:
try {
Gui 25:Cancel
FileSelectFile, files, 3,,Дешифровать файл, Все файлы (*.*)
if files =
	return
WinWaitClose Дешифровать файл
SplitPath, files, FiNam, Dir, Ext, Name
base = "%A_WorkingDir%\Sourse\bsed.exe" -d "%files%" "%A_Temp%\DBFFC.tmp\%FiNam%" 
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
} catch e {
	MsgBox % e "ERROR code 1009 BasD"
}
Return
;===================================================================================================
Tb2bt:
Gui 25:Cancel
Run, "%A_WorkingDir%\Sourse\tb2bt.exe"
Return
;===================================================================================================