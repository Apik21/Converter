Gui, +hwndhGui1 +Caption +AlwaysOnTop +Lastfound +E0x08020108
Gui, Color, 0xFFFFFF
Gui, Font, w700 s10

Resource := "resource.dll"    ; ���� � dll c ���������

hModule := DllCall("LoadLibrary", Str, Resource)
global hBitmap1 := DllCall("LoadImage", UInt, hModule
                              , UInt, 6000
                              , UInt, 0
                              , Int, 115, Int, 30  
                              , Uint, 0x8000)
global hBitmap2 := DllCall("LoadImage", UInt, hModule
                              , UInt, 6001
                              , UInt, 0
                              , Int, 115, Int, 30  
                              , Uint, 0x8000)

hBitmap3 := DllCall("LoadImage", UInt, hModule
                              , UInt, 6002
                              , UInt, 0
                              , Int, 217, Int, 140  
                              , Uint, 0x8000)
DllCall("FreeLibrary", UInt, hModule)


Gui, Add, GroupBox, x3 y10 w220 h165 hwndh_GB, ���������� ���� �����
Gui, Add, Picture, xp+1 yp+20 hwndh_Pic3 +0xE
SendMessage, 0x172, 0, hBitmap3,, ahk_id %h_Pic3% ; STM_SETIMAGE:=0x172, IMAGE_BITMAP:=0
Gui, Add, Picture, x65 y181 w100 h30 vBtClose gGuiClose hwndh_BtClose +0xE, % "HBITMAP:*" hBitmap1
SendMessage, 0x172, 0, hBitmap1,, ahk_id %h_BtClose%
Gui, Add, Picture, x209 y209 w16 h16 Icon211 gHelp, shell32.dll


Gui, 2:+hwndhGui2 +Owner1 -Caption +Border
Gui, 2:Add, Button, x5 y5 w120 h30 hwndhBt1 gGConvFile, ��������������
Gui, 2:Add, Button, x+5 y5 w120 h30 hwndhBt2 gGZipFile, �����
Gui, 2:Add, Button, x5 y+5 w120 h30 gGProtectFile, ������
Gui, 2:Add, Button, x+5 yp w120 h30 gGProperFile, ��������
Gui, 2:Add, Button, x60 y+5 w120 h30 hwndhBt3 gGEditPdf, �������� PDF
Gui, 2:Add, Text, x5 y+20 vInfo w250
Gui, 2:Add, Button, x60 y+30 w120 h30 gGExit, �������

Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 3:Add, Text, x2 y2  w250 Center , ��������� ���� � ������� `n ��������/���������/������� � �����.`n��� ����� ������?
Gui, 3:Add, Text, xp y+5 wp Center  , ������� �������� ������ ������� �� �������:`n��������������
Gui, 3:Add, Edit, xp y+5  wp Center hwndhVremya vVremya , %A_Now%
Gui, 3:Add, Button, xp y+5 w120 gVI, ����� ���������
Gui, 3:Add, Button, x+5 yp wp hp+25 gVD, ����� ���������� �������
Gui, 3:Add, Button, x2 yp+25 wp gVS, ����� ��������
Gui, 3:Add, Button, xp+60 y+20 wp gPrev, �����

global IntNum = 1
Gui, 4:+hwndhGui4 +owner1 -Caption +Border
Gui, 4:Add, Text, x5 y2 Center , ���������� � ���������� ������ �� ��������� Base64
Gui, 4:Add, Edit, xp y+5 w20 Center hwndhIntNum vIntNum, %IntNum%
Gui, 4:Add, Text, x+5 yp, ���������� �������� ���������� / ������������.
Gui, 4:Add, Button, x5 y+10 h40 w80 Center gBasE, ���������
Gui, 4:Add, Button, x+5 yp w80 h40 gBasD, �����������
Gui, 4:Add, Button, x70 y+10 w120 h30 gPrev, �����

Gui, 5:+hwndhGui5 +owner1 -Caption +Border
Gui, 5:Add, Text, x55 y3 Center , ������ ����� �� ������:
Gui, 5:Add, Button, x3 y+10 w55 Center hwndh_Ext1 gC_Jpg, JPG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext2 gC_Jpg, JPEG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext3 gC_Png, PNG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext4 gC_Ico, ICO
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext5 gC_Ps, PS
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext6 gC_Emf, EMF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext7 gC_Bmp, BMP
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext8 gC_Tif_Color, TIFF
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext9 gC_Tif_BnW, TIFF �/�
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext10 gC_Djvu, DJVU
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext11 gC_Pdf, PDF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext12 gC_Xpf, XPS
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext13 gC_Fb2, FB2
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext14 gC_Html, HTML
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext15 gC_Rtf, RTF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext16 gC_Mht, MHT
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext17 gC_Txt, TXT
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext18 gC_Xml, XML
Gui, 5:Add, Button, x70 y+10 w120 h30 gPrev, �����

Gui, 6:+hwndhGui6 +owner1 -Caption +Border
Gui, 6:Add, Text, x55 y3 Center , �������� ��������:
Gui, 6:Add, Button, x3 y+10 w100 h50 Center gSavePdfPage, ��������� ��������� ��������
Gui, 6:Add, Button, x+5 yp wp hp Center hwndh_Merge gMergePdfFile, ������� ��� � ����� pdf �����
Gui, 6:Add, Button, x3 y+5 wp hp Center gProtectPdfFile, ����������/����� ������ �� ����
Gui, 6:Add, Button, x+5 yp wp hp Center gFixPdfFile, ������������ ������������ ����
Gui, 6:Add, Button, x50 y+30 w120 h30 gPrev, �����

Gui, 7:+hwndhGui7 +owner1 -Caption +Border
Gui, 7:Add, Text, x55 y3 Center , �������� ��������:
Gui, 7:Add, Button, x3 y+10 w100 h50 Center gEProtectPdf, ��������
Gui, 7:Add, Button, x+5 yp wp hp Center gDProtectPdf, ����� ������
Gui, 7:Add, Button, x50 y+30 w120 h30 gPrev, �����

Gui, 8:+hwndhGui8 +owner1 -Caption +Border
Gui, 8:Add, Edit, x5 y10 w290 h25 vStran HWNDh_SavePage
Gui, 8:Add, Text, x5 y40 w290 h40, ������� ����������� ��������:1, 3-5, 8. ��� �������� ����� �������� ������� ������ ��������: left, right, down.
Gui, 8:Add, Button, x5 y85 w140 h30 gSplt, ��������� ��������� ��������
Gui, 8:Add, Button, x160 y85 w60 h30 gPrev, �����

Gui, 9:+hwndhGui9 +owner1 -Caption +Border
Gui, 9:Add, Edit, x5 y5 w60 h25 vQuality , 85
Gui, 9:Add, Text, x70 y5 w150 h30 r2 , �������� `n 99-max 1-min
Gui, 9:Add, CheckBox, x5 y40 w150 h25 vDelStatus, ������� �������� �����
Gui, 9:Add, Button, x5 y70 w100 h30 gRunZipFile, OK
Gui, 9:Add, Button, x115 y70 w100 h30 gPrev, �����


Gui, 10:+hwndhGui10 +owner1 -Caption +Border
Gui, 10:Add, Edit, x5 y5 w60 h25 vQual , 85
Gui, 10:Add, Text, xp+65 yp w205 h25, ��������: 99-max 1-min
Gui, 10:Add, CheckBox, xp-65 yp+35 w270 h25 vDelSt, ������� �������� �����
Gui, 10:Add, Edit, xp y+5 w270 h25 vPage HWNDh_Page
Gui, 10:Add, Text, xp y+5 w270 h40, ������� �������������� ��������:1, 3-5, 8.
Gui, 10:Add, Button, xp+10 y+10 w100 h30 gConv_jpg, OK
Gui, 10:Add, Button, xp+110 yp w100 h30 gPrev, �����

GuiControl, Focus, %h_GB%
Gui, Show, x550 y260 h225 w225, ��������� 2.0.0a
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - �������, 1010F1 - �������
