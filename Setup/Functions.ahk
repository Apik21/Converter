;================================FUNCTIONS==========================================================
;===================================================================================================
ConnectedToInternet(flag=0x40)
{
	Return DllCall("wininet.dll\InternetGetConnectedState", "Str", flag,"Int",0)
}
;===================================================================================================
ELM(ERR,e_msg, e_off=0)
{
	If ERR =1 
	{
		If e_off = 1
		{
			Msgbox, 48, Ошибка, %e_msg%
			return
		}
		else
			Msgbox, 48, Ошибка, %e_msg%
	}
}
;===================================================================================================
Architectura()
{
ThisProcess := DllCall("GetCurrentProcess")
if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
    IsWow64Process := false
Sys := % IsWow64Process ? "win64" : "win32"
return %Sys%
}

;===================================================================================================
WaitProgress(runing = 0, ALE = 0, EL = 0)
{
	if runing = 1
	{
		Gui, 1:Default
		SB_SetText("Выполнение...", 1)
		GuiControl,, Progr, 25
		sleep 500
		GuiControl,, Progr, 50
	}
	else
	{
		SB_SetText("", 1)
		If ((ALE = 0) or (EL != "ERROR"))
		{
			GuiControl,, Progr, 75
			Sleep 500
			GuiControl,, Progr, 100
			MsgBox, 64, Конвертер, Готово!, 1
			GuiControl,, Progr, 0
		}
		Else
		{
			MsgBox, 16, Конвертер, Ошибка выполнения. Код ошибки - %ALE%. Обратитесь к разработчику., 1
			GuiControl,, Progr, 0
		}
	}	
}

;===================================================================================================
FuncGui(wp, lp, msg, hwnd)
{
	global hGui1, WI, i
	static k
	if (msg = 0x112)
	{
		if (wp = 0xF020 && k := 1)           ; SC_MINIMIZE = 0xF020
			Gui, %GuiNum%:Show, Hide           ; скрываем окно-слайдер, если оно выдвинуто, при минимизации основного окна
		if (wp = 0xF120 && !(k := 0) && i)   ; SC_RESTORE = 0xF120
			Gui, %GuiNum%:Show                 ; показываем окно-слайдер, если оно было выдвинуто, при восстановлении основного окна
	}
	if (!i || hwnd != hGui1 || k = 1) 
		return
	; привязываем окно-слайдер к нижней границе основного окна   
	DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
	xI := NumGet(WI, 20, UInt)
	yI := NumGet(WI, 16, UInt)
	Gui, %GuiNum%:Show, x%xI% y%yI% h%GuiHigh% w300
}
;===================================================================================================
;===================================================================================================
;================================FUNCTIONS==========================================================