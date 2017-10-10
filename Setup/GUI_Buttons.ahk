;===================================================================================================
;==========================Конвертирование Png======================================================
ButtonPNG:
DnDPng = ""
BPNG:
AllGUICancel()
global GuiNum := % GuHi[22].GuiN
global GuiHigh := % GuHi[22].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 22:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h" GuiHigh " w300"
   DllCall("AnimateWindow", Ptr, hGui22, UInt, 300, UInt, 0x40000|(i ? 1 : 0x10002))    ;выдвигаем/задвигаем окно-слайдер
return
;==========================Конвертирование Jpg======================================================
ButtonJPG:
DnDJpeg = ""
BJPG:
AllGUICancel()
global GuiNum := % GuHi[12].GuiN
global GuiHigh := % GuHi[12].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 12:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h" GuiHigh " w300"
   DllCall("AnimateWindow", Ptr, hGui12, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))    ;выдвигаем/задвигаем окно-слайдер
return
;===========================Конвертирование Pdf=====================================================
ButtonPDF:
DnDPdf = ""
BPDF:
AllGUICancel()
global GuiNum := % GuHi[13].GuiN
global GuiHigh := % GuHi[13].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, 13:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " w300 h" GuiHigh
   DllCall("AnimateWindow", Ptr, hGui13, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
return
;=============================Конвертирование Tiff =================================================
ButtonTIFF:
DnDTiff = ""
BTIFF:
AllGUICancel()
global GuiNum := % GuHi[14].GuiN
global GuiHigh := % GuHi[14].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")   ; WM_SYSCOMMAND = 0x112
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
   if i := !i
      Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") " h" GuiHigh " w300"
   DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))   ; выдвигаем/задвигаем окно-слайдер
return 
;=============================Обработка PDF =================================================
ZP:
AllGUICancel()
global GuiNum := % GuHi[9].GuiN
global GuiHigh := % GuHi[9].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") "w300 h" GuiHigh
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008)) ;выдвигаем/задвигаем окно-слайдер
return
;============================Сжатие TIFF======================================================
ZT:
AllGUICancel()
FileSelectFile, files, 3,,Сжатие TIFF, Изображения (*.tiff; *.tif)
if files =
    return
WinWaitClose Сжатие TIFF
global GuiNum := % GuHi[7].GuiN
global GuiHigh := % GuHi[7].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") "w300 h" GuiHigh
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
return
;==============================Сжатие JPG======================================================
ZJ:
AllGUICancel()
FileSelectFile, files, M3,,Сжатие JPG, Изображения (*.jpg; *.jpeg)
if files =
    return
WinWaitClose Сжатие JPG
global GuiNum := % GuHi[6].GuiN
global GuiHigh := % GuHi[6].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") "w300 h" GuiHigh
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008))
return
;===================================================================================================	
DOC:
DnDDoc = ""
BDOC:
AllGUICancel()
VarSetCapacity(WI, 64)
global GuiNum := % GuHi[11].GuiN
global GuiHigh := % GuHi[11].Hg
OnMessage(0x3, "FuncGui")
OnMessage(0x112, "FuncGui")
DllCall("GetWindowInfo", Ptr, hGui1, Ptr, &WI)
if i := !i
	Gui, %GuiNum%:Show, % "x" NumGet(WI, 20, "UInt") " y" NumGet(WI, 16, "UInt") "w300 h" GuiHigh
DllCall("AnimateWindow", Ptr, hGui%GuiNum%, UInt, 300, UInt, 0x00040000|(i ? 1 : 0x10008)) ;выдвигаем/задвигаем окно-слайдер
return
;===================================================================================================
;===================================================================================================