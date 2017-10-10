;==========================Дата===================================================================
Dt:
AllGUICancel()
global GuiNum := % GuHi[21].GuiN
global GuiHigh := % GuHi[21].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h" GuiHigh " w300"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return

VI:
FileSelectFile, files, M3,,Редактирование времени изменения файла, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
    return

WinWaitClose Редактирование времени изменения файла
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
{
    if a_index = 1
		path = %A_LoopField%
	else
        FileSetTime, %Vremya%, %path%\%A_LoopField% , M ; Установить дату изменения (время будет полночь)
}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

VS:
FileSelectFile, files, M3,,Редактирование времени создания файла, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
    return

WinWaitClose Редактирование времени создания файла
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
{
    if a_index = 1
		path = %A_LoopField%
	else
        FileSetTime, %Vremya%, %path%\%A_LoopField% , C ; Установить дату изменения (время будет полночь)
}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

VD:
Gui, 21:Submit
FileSelectFile, files, M3,,Редактирование времени последнего доступа к файлу, Все файлы (*.*) ; M3 = Множественный выбор существующих файлов.
if files =
    return

WinWaitClose Редактирование времени последнего доступа к файлу
GuiControlGet, Vremya
Gui, 21:Submit
Loop, parse, files, `n
{
    if a_index = 1
		path = %A_LoopField%
	else
		FileSetTime, %Vremya%, %path%\%A_LoopField% , A 
}
sleep 500
ControlClick, JPG,Конвертер, , LEFT
MsgBox, 64,Конвертер, Готово!, 1
return

;===================================================================================================