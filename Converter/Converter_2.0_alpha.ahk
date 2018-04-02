Readme =
(
������ ������ ������������ ����� ����������� �������� ��� 
���������� �������� ��������������� ������ �����������.
����� ���: NConverter, GScript, PdfTk, Doc2Html, Pdf2Djvu.

���� ������������� ������������ �������� ����� ���� � 
��������� � ������ �������� � ��������� � ������ /bin � /p2d.

)
DetectHiddenWindows, On
#NoEnv
#SingleInstance Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
FileCreateDir, %A_Temp%\DBFFC.tmp
CodePage = chcp 866

OnMessage(WM_CTLCOLOREDIT := 0x133, "WM_CTLCOLOR")
OnMessage(WM_CTLCOLORSTATIC := 0x138, "WM_CTLCOLOR")
OnMessage(0x201, "WM_LBUTTONDOWN") ; �������������� ���� �����
OnMessage(0x200, "WM_MOUSEMOVE") ; ��������� �����

Global Ctrl := []
global gs, cv, FileList, PrevNum, GuiNum, hReadme, hGui1
global Ext := ""
global Dir := ""
global Name := ""
global extArray := ["jpg", "jpeg", "pdf", "tif", "tiff", "png", "ico", "bmp", "txt", "doc", "docx", "rtf", "html", "xml", "mht", "djvu"] ; ���������� ������ ���������� ����������� ������ ��� ��������������� � ������

Architectura()
if (sys = "win64"){
	gs := "gswin64c.exe"
	cv := "convert64.exe"
} else if (sys = "win32"){
	gs := "gswin32c.exe"
	cv := "convert.exe"
}

#Include UI.ahk ; ���������������� ���������

VarSetCapacity(WI, 64)
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
Return

#Include main.ahk ; �������� ������� ����������

GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) ; ������� �������������� 
{
	Loop, 30 {
		if A_Index > 2
			Gui, %A_Index%:Submit
	}
	
	global coolFiles := FileArray.MaxIndex()    ; �������� ���������� �������� ������
	If coolFiles = 1   ; ���� ������ ���� ����
	{
		global OneFile := A_GuiControlEvent
		Ext := "" , global search := ""
		SplitPath, OneFile,, Dir, Ext, Name
		for i, value in extArray
			search := Ext = value ? true : search = true ? true : "" ; ��������� �������� �������� ���������� ����������� ����� � ��������
		search := search = "" ? false : true
		gosub, gGui2 ; ������� �� �������� �������� ���� ������ �������� Gui2
	}
	else if coolFiles > 1
	{
		Ext := "" , global search := ""
		global AreaFile := A_GuiControlEvent
		Loop, parse, A_GuiControlEvent, `n 
		{
			if A_Index = 1
			{
				SplitPath, A_LoopField,,, Ext
				FileList = '%A_LoopField%'
			}
			else
			{
				SplitPath, A_LoopField,,, ExtN
				If (Ext != ExtN)
					MsgBox "�������� ����� � ���������� ������������, ��������� ������� � ������� ������ ���� ����������." , return
				FileList .= ", '"   A_LoopField "' "
			}
		}
		for i, value in extArray
			search := Ext = value ? true : search = true ? true : "" ; ��������� �������� �������� ���������� ���������� ������ � ��������
		search := search = "" ? false : true
		gosub, gGui2 ; ������� �� �������� �������� ���� ������ �������� Gui2
		return
	}
	return
}

gGui2:
global GuiNum = 2
global search
global Ext
GuiControl, %GuiNum%:Disable, %hBt1%
GuiControl, %GuiNum%:Disable, %hBt2%
GuiControl, %GuiNum%:Disable, %hBt3%
if (search != 0) ;���� ����� �� ������ ��������������
	GuiControl, %GuiNum%:Enable, %hBt1%
If (Ext = "jpg" || Ext = "jpeg" || Ext = "pdf" || Ext = "tif" || Ext = "tiff") ; ���� ���� ����� ��� ����������
	GuiControl, %GuiNum%:Enable, %hBt2%
If (Ext = "pdf") ; ���� ���� pdf
	GuiControl, %GuiNum%:Enable, %hBt3%

msg_Info := "�������� " coolFiles " ����(��) � ����������� " Ext
GuiControl,2:, Info, %msg_Info%

DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; ���������/��������� ����-�������
return


 
GExit: ; Gui �������
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt") 
				. " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " hide"
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 400, UInt, 0x40000|(i ? 1 : 0x10002))   ; ���������/��������� ����-�������
Gui, %GuiNum%:submit
Gui, Default
return

GuiClose:
GuiEscape:
FileRemoveDir, %A_Temp%\DBFFC.tmp, 1
DllCall("DeleteObject", UInt, hBitmap)
ExitApp

; ***********************************�������� ����������� �������**************************************
Architectura() {
	ThisProcess := DllCall("GetCurrentProcess")
	if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
		IsWow64Process := false
	global Sys := % IsWow64Process ? "win64" : "win32"
	return %Sys%
}

;~ ***********************������� �������� ��������/�������� �������������� ����************************
FuncGui(wp, lp, msg, hwnd) {
   global hGui1, WI, i, GuiNum
   static k
   if GuiNum = 
		GuiNum := 1
   if (msg = 0x112)
   {
      if (wp = 0xF020 && k := 1)   
         Gui, %GuiNum%:Show, Hide   ; �������� ����-�������, ���� ��� ���������, ��� ����������� ��������� ����
      
      if (wp = 0xF120 && !(k := 0) && i)   
         Gui, %GuiNum%:Show   ; ���������� ����-�������, ���� ��� ���� ���������, ��� �������������� ��������� ����
   }
   if (!i || hwnd != hGui1 || k = 1)
      return
   DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)  ; ����������� ����-������� � ������ ������� ��������� ����   
   Gui, %GuiNum%:Show, % "x" NumGet(WI, 12, "UInt") " y" NumGet(WI, 24, "UInt")
               . " h" NumGet(WI, 32, "UInt") - NumGet(WI, 24, "UInt") " NA"
}

;~ **************************������� ��� �������������� GroupBox �� ����� ���������� ��������*************************
SetControlColor(hwnd, BG, FG) { 
	Ctrl[hwnd] := {BG:BG,FG:FG}
	WM_CTLCOLOR(DllCall("GetDC", "Ptr", hwnd), hwnd)
	DllCall("RedrawWindow", "Ptr", hwnd, "Uint", 0, "Uint", 0, "Uint", 0x1|0x4)
}

WM_CTLCOLOR(wParam, lParam) {  
	If !Ctrl.HasKey(lParam) 
		Return 0 
	hBrush := DllCall("CreateSolidBrush", UInt, Ctrl[lParam].BG)
	DllCall("SetTextColor", Ptr, wParam, UInt, Ctrl[lParam].FG)
	DllCall("SetBkColor", Ptr, wParam, UInt, Ctrl[lParam].BG)
	DllCall("SetBkMode", Ptr, wParam, UInt, 2)
	Return hBrush 
}

;~ ***************************************************�������������� ���� �����*****************************************
WM_LBUTTONDOWN() {
	WM_NCLBUTTONDOWN := 0xA1, HTCAPTION := 2
	PostMessage, WM_NCLBUTTONDOWN, HTCAPTION
}

;~ ***************************************************��������� ������ ��� ��������� �������*****************************
WM_MOUSEMOVE(wp, lp, msg)  {
	CoordMode, ToolTip, Window 
	static hover := {}
	if (msg = "timer")  {
		MouseGetPos,,,, hControl, 2
		if (hControl != lp)  {
			ToolTip
			SetTimer,, Delete
			hover[lp] := false
			GuiControl,, BtClose, % "HBITMAP:*" hBitmap1
		}
	}
	else  {
      GuiControlGet, hText, hwnd, %A_GuiControl%
		if ( !hover[hText] && InStr(A_GuiControl, "BtClose") )  {
			hover[hText] := true
			GuiControl,, BtClose, % "HBITMAP:*" hBitmap2
			ToolTip, ������� ���������
			timer := Func(A_ThisFunc).Bind(A_Gui, hText, "timer")
			SetTimer, % timer, 100
		}
	}
}
;~ ***************************************************�������***********************************************************

ShowOwnerWindow(Title, hWnd)
{
   WinGetPos, X_Main, Y_Main, W_Main,, ahk_id %hGui1%
   Gui, Show, Hide, % Title
   DetectHiddenWindows, On
   WinGetPos,,, W,, ahk_id %hWnd%
   Gui, Show, % "Hide x" X_Main - W " y" Y_Main
   WinGetPos, X, Y, W, H, ahk_id %hWnd%
   (X < 0 && X := X_Main + W_Main)
   (X + W > A_ScreenWidth && X := A_ScreenWidth - W)
   (Y < 0 && Y := 0)
   (Y + H > A_ScreenHeight && Y := A_ScreenHeight - H)
   WinMove, ahk_id %hWnd%,, X, Y, W, H
   Gui, Show
}