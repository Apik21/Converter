Gui, +hwndhGui1 +Caption +AlwaysOnTop +Lastfound +E0x08020108
Gui, Color, 0xFFFFFF
Gui, Font, w700 s10

Resource = %A_WorkingDir%\resource.dll    ; путь к dll c ресурсами

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
                              , Int, 217, Int, 160  
                              , Uint, 0x8000)
DllCall("FreeLibrary", UInt, hModule)
MsgBox,,UI, % hBitmap1 " , " hBitmap2 " , " hBitmap3 " , " hModule   ; TEST

Gui, Add, GroupBox, x3 y10 w220 h165 hwndh_GB, Перетащите сюда файлы
Gui, Add, Picture, xp+1 yp+3 hwndh_Pic3 +0xE
SendMessage, 0x172, 0, hBitmap3,, ahk_id %h_Pic3% ; STM_SETIMAGE:=0x172, IMAGE_BITMAP:=0
Gui, Add, Picture, x65 y181 w100 h30 vBtClose gGuiClose hwndh_BtClose +0xE, % "HBITMAP:*" hBitmap1
SendMessage, 0x172, 0, hBitmap1,, ahk_id %h_BtClose%


Gui, 2:+hwndhGui2 +Owner1 -Caption +Border
Gui, 2:Add, Button, x5 y5 w120 h30 hwndhBt1 gGConvFile, Конвертировать
Gui, 2:Add, Button, x+5 y5 w120 h30 hwndhBt2 gGZipFile, Сжать
Gui, 2:Add, Button, x5 y+5 w120 h30 gGProtectFile, Защита
Gui, 2:Add, Button, x+5 yp w120 h30 gGProperFile, Свойства
Gui, 2:Add, Button, x60 y+5 w120 h30 hwndhBt3 gGEditPdf, Редактор PDF
Gui, 2:Add, Text, x5 y+20 vInfo w250
Gui, 2:Add, Button, x60 y+30 w120 h30 gGExit, Закрыть

Gui, 3:+hwndhGui3 +owner1 -Caption +Border
Gui, 3:Add, Text, x2 y2  w250 Center , Изменение даты и времени `n создания/изменения/доступа к файлу.`nЧто будем менять?
Gui, 3:Add, Text, xp y+5 wp Center  , Введите значение нового времени по образцу:`nГГГГММДДччммсс
Gui, 3:Add, Edit, xp y+5  wp Center hwndhVremya vVremya , %A_Now%
Gui, 3:Add, Button, xp y+5 w120 gVI, Время изменения
Gui, 3:Add, Button, x+5 yp wp hp+25 gVD, Время последнего доступа
Gui, 3:Add, Button, x2 yp+25 wp gVS, Время создания
Gui, 3:Add, Button, xp+60 y+20 wp gPrev, Назад

global IntNum = 1
Gui, 4:+hwndhGui4 +owner1 -Caption +Border
Gui, 4:Add, Text, x5 y2 Center , Шифрование и дешифровка файлов по алгоритму Base64
Gui, 4:Add, Edit, xp y+5 w20 Center hwndhIntNum vIntNum, %IntNum%
Gui, 4:Add, Text, x+5 yp, Количество проходов шифрования / дешифрования.
Gui, 4:Add, Button, x5 y+10 h40 w80 Center gBasE, Шифровать
Gui, 4:Add, Button, x+5 yp w80 h40 gBasD, Дешифровать
Gui, 4:Add, Button, x70 y+10 w120 h30 gPrev, Назад

Gui, 5:+hwndhGui5 +owner1 -Caption +Border
Gui, 5:Add, Text, x55 y3 Center , Формат файла на выходе:
Gui, 5:Add, Button, x3 y+10 w55 Center hwndh_Ext1, JPG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext2, JPEG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext3, PNG
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext4, ICO
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext5, PS
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext6, EMF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext7, BMP
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext8, TIFF
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext9, TIFF ч/б
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext10, DJVU
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext11, PDF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext12, XPS
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext13, FB2
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext14, HTML
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext15, RTF
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext16, MHT
Gui, 5:Add, Button, x3 y+5 wp Center hwndh_Ext17, TXT
Gui, 5:Add, Button, x+5 yp wp Center hwndh_Ext18, XML
Gui, 5:Add, Button, x70 y+10 w120 h30 gPrev, Назад

Gui, 6:+hwndhGui6 +owner1 -Caption +Border
Gui, 6:Add, Text, x55 y3 Center , Выберите действие:
Gui, 6:Add, Button, x3 y+10 w100 h50 Center gSavePdfPage, Сохранить выбранные страницы
Gui, 6:Add, Button, x+5 yp wp hp Center hwndh_Merge gMergePdfFile, Склеить два и более pdf файла
Gui, 6:Add, Button, x3 y+5 wp hp Center gProtectPdfFile, Установить/снять защиту на файл
Gui, 6:Add, Button, x+5 yp wp hp Center gFixPdfFile, Восстановить поврежденный файл
Gui, 6:Add, Button, x50 y+30 w120 h30 gPrev, Назад

Gui, 7:+hwndhGui7 +owner1 -Caption +Border
Gui, 7:Add, Text, x55 y3 Center , Выберите действие:
Gui, 7:Add, Button, x3 y+10 w100 h50 Center gEProtectPdf, Защитить
Gui, 7:Add, Button, x+5 yp wp hp Center gDProtectPdf, Снять защиту
Gui, 7:Add, Button, x50 y+30 w120 h30 gPrev, Назад

Gui, 8:+hwndhGui8 +owner1 -Caption +Border
Gui, 8:Add, Edit, x5 y10 w290 h25 vStran HWNDh_SavePage
Gui, 8:Add, Text, x5 y40 w290 h40, Укажите сохраняемые страницы:1, 3-5, 8. Для поворота после страницы указать сторну поворота: left, right, down.
Gui, 8:Add, Button, x5 y85 w140 h30 gSplt, Сохранить выбранные страницы
Gui, 8:Add, Button, x160 y85 w60 h30 gPrev, Назад

Gui, 9:+hwndhGui9 +owner1 -Caption +Border
Gui, 9:Add, Edit, x5 y5 w60 h25 vQuality , 85
Gui, 9:Add, Text, x70 y5 w150 h30 r2 , Качество `n 99-max 1-min
Gui, 9:Add, CheckBox, x5 y40 w150 h25 vDelStatus, УДАЛИТЬ исходные файлы
Gui, 9:Add, Button, x5 y70 w100 h30 gRunZipFile, OK
Gui, 9:Add, Button, x115 y70 w100 h30 gPrev, Назад

GuiControl, Focus, %h_GB%
Gui, Show, x550 y260 h225 w225, Конвертер 2.0.0a
SetControlColor(h_GB, 0xA2EEA9, 0x000000) ; 0xA2EEA9 - зеленый, 1010F1 - красный