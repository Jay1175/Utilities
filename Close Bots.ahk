#SingleInstance ignore

InputBox, minutes, Sleep Timer, Enter in minutes: (60 default), , 200, 125, , , , 15,
	if (minutes = "")
		{
		minutes = 60
		}

ms := (minutes * 60000)

Sleep % ms

	if WinExist("Toontown Multicontroller")
		WinClose

Sleep, 250

	if WinExist("Toontown Multicontroller")
		WinClose

Sleep, 250

DetectHiddenWindows, On
WinGet, AHKList, List, ahk_class AutoHotkey
Loop, %AHKList%
{
    ID := AHKList%A_Index%
    If (ID <> A_ScriptHwnd)
        WinClose, ahk_id %ID%
}
Return

ExitApp