#SingleInstance ignore

InputBox, minutes, Sleep Timer, Enter in minutes: (60 default), , 200, 125, , , , 15,
	if (minutes = "")
		{
		minutes = 60
		}

ms := (minutes * 60000)

Sleep % ms

Process, Close, msedge.exe

ExitApp