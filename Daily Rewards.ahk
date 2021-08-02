MsgBox, 6, Daily Rewards, Daily rewards will be collected in 1 minute - Try Again will wait an hour before collecting., 60
	IfMsgBox TryAgain
		{
		ToolTip, Sleeping 1 hour...
		Sleep, 3600000
		Reload
		}
	else IfMsgBox Cancel
		{
		ExitApp
		}
		
	else
		{
		Collect()
		}

global rotmg := 0
global btd6 := 0


collect()
{
	global rotmg
	global btd6

if (rotmg < 4)
	{
	ToolTip, Launching RotMG in 1 minute...
	Sleep, 60000
	rotmg()
	}
	
if (btd6 < 4)
	{
	ToolTip, Launching BTD6 in 1 minute...
	Sleep, 60000
	btd6()
	}

			if (rotmg != 100)
				{
				ToolTip
				MsgBox, Problems encountered when launching RotMG - tried %rotmg% times.
				#Persistent
				}
				
			if (btd6 != 100)
				{
				ToolTip
				MsgBox, Problems encountered when launching BTD6 - tried %btd6% times.
				#Persistent
				}
				
ExitApp
}

rotmg()
{
	global rotmg

Run, steam://rungameid/200210

	ToolTip, Searching for Play button...
	
	Sleep, 5000

	WinGetActiveStats, Title, Width, Height, X, Y
	CWidth := Ceil(Width*0.5)
	CHeight := Ceil(Height*0.5)
	MouseMove, %CWidth%, %CHeight%
	
	PBx1 := Ceil(0.75612 * Width)
	PBy1 := Ceil(0.876369 * Height)
	PBx2 := Ceil(0.970588 * Width)
	PBy2 := Ceil(0.94201 * Height)
	
	Sleep, 7500
	
	PixelSearch, Px, Py, %PBx1%, %PBy1%, %PBx2%, %PBy2%, 0x009477, 5, fast
		if ErrorLevel = 1
		{
			rotmg++
			
				ToolTip, Play button not found in time...
				if WinExist("RotMG Exalt Launcher")
					WinClose
					Sleep, 1000
				if (rotmg < 4)
					{
					collect()
					}
				else
				{
				;ToolTip, Too many failures - skipping game.
				;Sleep, 2000
				Return 3
				}
		}
		if ErrorLevel = 0
		{
			Sleep, 250
			MouseMove, %Px%, %Py%
			Sleep, 500
			Click		
		}

	if rotmg between 1 and 99
		{
		ToolTip, Previous launches failed - waiting 5 minutes for possible update...
		Sleep, 300000
		}
	else
		Sleep, 10000

	WinGetActiveStats, Title, Width, Height, X, Y
	
	Lx1 := Ceil(0.054945 * Width)
	Ly1 := Ceil(0.0425985 * Height)
	Lx2 := Ceil(0.137362 * Width)
	Ly2 := Ceil(0.106496 * Height)

static i:=0
Loop
	{
	i++
	Sleep, 6000
	PixelSearch, Px, Py, %Lx1%, %Ly1%, %Lx2%, %Ly2%, 0xFFFFFF, 0, fast
	if (ErrorLevel = 1)
		{
		ToolTip, Not logged in yet - %i% of 20 checks...
			if (i = 20)
				{
				rotmg++
				
					ToolTip, Not launched in time...
						Sleep, 2500						
					if WinExist("RotMGExalt")
						WinClose	
					Sleep, 5000

					if WinExist("RotMG Exalt Launcher")
						WinClose
					Sleep, 5000
				
						if (rotmg < 4)
							collect()
						else
							{
							Sleep, 500
							Return 3
							}
				}
			else		
				Continue
		}
	if (ErrorLevel = 0)
		{
		ToolTip, Appears to be logged in - closing game in 1 minute...

			Sleep, 60000
				if WinExist("RotMGExalt")
					WinClose	
			Sleep, 5000

				if WinExist("RotMG Exalt Launcher")
					WinClose
		Break
		}
	}
	
	global rotmg := 100
	
Return
}

btd6()
{

global btd6

Run, steam://rungameid/960090

	ToolTip, Searching for Start button...
	
	Sleep, 5000
	
	WinGetActiveStats, Title, Width, Height, X, Y
	CWidth := Ceil(Width*0.5)
	CHeight := Ceil(Height*0.5)
	MouseMove, %CWidth%, %CHeight%
	
	PBx1 := Ceil(0.42438 * Width)
	PBy1 := Ceil(0.88200 * Height)
	PBx2 := Ceil(0.57484 * Width)
	PBy2 := Ceil(0.95352 * Height)
	
	Sleep, 10000
	PixelSearch, Sx, Sy, %PBx1%, %PBy1%, %PBx2%, %PBy2%, 0x00D95E, 10, fast
		if ErrorLevel = 1
		{
		btd6++
			ToolTip, Start button was not found in time...
				if WinExist("BloonsTD6")
					WinClose
			Sleep, 1000
				if (btd6 < 4)
				{
				collect()
				}
				else
				{
				Sleep, 500
				Return 3
				}
				
		}
		if ErrorLevel = 0
		{
			Sleep, 250
			MouseMove, %Sx%, %Sy%
			Sleep, 500
			Click
		}

	ToolTip, Searching for daily chest...
	WinGetActiveStats, Title, Width, Height, X, Y
	
	Cx1 := Ceil(0.23534 * Width)
	Cy1 := Ceil(0.56019 * Height)
	Cx2 := Ceil(0.30093 * Width)
	Cy2 := Ceil(0.63170 * Height)
	Sleep, 15000
	PixelSearch, Cx, Cy, %Cx1%, %Cy1%, %Cx2%, %Cy2%, 0x2C508C, 5, fast
		if ErrorLevel = 1
		{
		btd6++
			ToolTip, Daily chest was not found in time...
				if WinExist("BloonsTD6")
					WinClose
			Sleep, 10000
				if (btd6 < 4)
				{
				collect()
				}
				else
				{
				Sleep, 500
				Return 3
				}
		}
		if ErrorLevel = 0
		{
			Sleep, 250
			MouseMove, %Cx%, %Cy%
			Sleep, 500
			Click
			ToolTip
		}

Sleep, 3000
	if WinExist("BloonsTD6")
		WinClose

	global btd6 := 100

Return 2
}