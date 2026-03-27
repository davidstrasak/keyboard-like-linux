#Requires AutoHotkey v2.0

#HotIf ; Bude fungovat vsude 
#b::
{
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Brave.lnk"
}

#k::
{
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\KeePassXC\KeePassXC.lnk"
}

#a::
{
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AIMP\AIMP.lnk"
}

#t::
{
    Run("powershell -NoExit -Command Set-Location C:\")
}

#+t::
{
    Run("C:\Program Files\Git\git-bash.exe --cd-to-home")
    ; Wait for the mintty window to appear (timeout 3 seconds) and activate it
    if WinWait("ahk_class mintty", , 3)
        WinActivate("ahk_class mintty")
}

#g::
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\REAPER (x64)\REAPER (x64).lnk"
}

#m::
{
	Run "matlab"
}

#v::
{
	Run "C:\Users\David\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk"
}

#w::
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Obsidian.lnk"
}

#c::
{
	Send "#v"
}

^+x::
{
	Send "^+e"
}

#p::
{
	Run "C:\Program Files\Adobe Photoshop CC 2019\Photoshop.exe"
}

#i::
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe Illustrator CC 2019.lnk"
}

#s::
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TeXstudio.lnk"
}

^+d:: ; ctrl shift d
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TickTick\TickTick.lnk"
}

#SC004:: ; win+š
{
	Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Bambu Studio\Bambu Studio.lnk"
}

^!SC029:: ; altgr ;
{
    SendText(Chr(96))
}

+^!SC029:: ; shift altgr ;
{
    SendText(Chr(126))
}

^!F::	;	altgr F
{
    SendText "["
}

^!SC002::	;	altgr +
{
    SendText "!"
}

^!SC003::	;	altgr ě
{
    SendText "@"
}

^!SC004::	;	altgr š
{
    SendText "#"
}

^!SC005::	;	altgr č
{
    SendText "$"
}

^!SC006::	;	altgr ř
{
    SendText "%"
}

^!SC007::	;	altgr ž
{
    SendText "^"
}

^!SC008::	;	altgr ý
{
    SendText "&"
}

^!SC009::	;	altgr á
{
    SendText "*"
}

^!SC00A::	;	altgr í
{
    SendText "("
}

^!SC00B::	;	altgr é
{
    SendText ")"
}

^!SC01A::	;	altgr ú
{
    SendText "["
}

^!SC01B::	;	altgr )
{
    SendText "]"
}

+^!SC01A::	;	shift altgr ú
{
    SendText "{"
}

+^!SC01B::	;	shift altgr )
{
    SendText "}"
}

^!SC02B::	;	altgr ¨
{
    SendText "\"
}

+^!SC02B::	;	shift altgr ¨
{
    SendText "|"
}