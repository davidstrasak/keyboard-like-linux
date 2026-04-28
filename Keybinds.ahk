#Requires AutoHotkey v2.0

; Setup for the scripts moving windows using mouse buttons
InstallMouseHook()
SetWinDelay(-1) ; Eliminate AHK's internal delay between window commands

; Win + T = terminal
#SC14::
{
  Run("powershell -NoExit -Command `"Set-Location 'C:\'`"")
}

; Win + Shift + T = Git Bash
#+SC14::
{
    Run('wt -p "Git Bash"')

    ; Activate Windows Terminal
    if WinWait("ahk_exe WindowsTerminal.exe", , 3)
        WinActivate("ahk_exe WindowsTerminal.exe")
}

; Win + W = obsidian
#SC11::
{
  Run("C:\Users\stras003\AppData\Local\Programs\Obsidian\Obsidian.exe")
}

; Win + V = vscode
#SC2F::
{
  Run("C:\Users\stras003\AppData\Local\Programs\Microsoft VS Code\Code.exe")
}

#b::
{
  Run("C:\Users\stras003\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe")
}

; Win + C = clipboard history
#SC2E::
{
  Send("#v")
}

; Ctrl+Shift+Z (or Y on CZ keyboard layout) = Ticktick timer
^+SC2C::
{
  Send("^+Z")
}

; Ctrl+Shift+X = Ticktick open
^+x::
{
  Send("^+E")
}

; ------------------------------------------- Keyboard like linux -------------------------------------------
<^>!SC029:: ; altgr ;
>!SC029::
{
    SendText(Chr(96))
}

<+^>!SC029:: ; shift altgr ;
>+!SC029::
{
    SendText(Chr(126))
}

<^>!F::	;	altgr F
>!F::
{
    SendText "["
}

<^>!SC002::	;	altgr +
>!SC002::
{
    SendText "!"
}

<^>!SC003::	;	altgr ě
>!SC003::
{
    SendText "@"
}

<^>!SC004::	;	altgr š
>!SC004::
{
    SendText "#"
}

<^>!SC005::	;	altgr č
>!SC005::
{
    SendText "$"
}

<^>!SC006::	;	altgr ř
>!SC006::
{
    SendText "%"
}

<^>!SC007::	;	altgr ž
>!SC007::
{
    SendText "^"
}

<^>!SC008::	;	altgr ý
>!SC008::
{
    SendText "&"
}

<^>!SC009::	;	altgr á
>!SC009::
{
    SendText "*"
}

<^>!SC00A::	;	altgr í
>!SC00A::
{
    SendText "("
}

<^>!SC00B::	;	altgr é
>!SC00B::
{
    SendText ")"
}

<^>!SC01A::	;	altgr ú
>!SC01A::
{
    SendText "["
}

<^>!SC01B::	;	altgr )
>!SC01B::
{
    SendText "]"
}

<+^>!SC01A::	;	shift altgr ú
>+!SC01A::
{
    SendText "{"
}

<+^>!SC01B::	;	shift altgr )
>+!SC01B::
{
    SendText "}"
}

<^>!SC02B::	;	altgr ¨
>!SC02B::
{
    SendText "\"
}

<+^>!SC02B::	;	shift altgr ¨
>+!SC02B::
{
    SendText "|"
}

; ------------------------------------------- Monitor Switching (Shift + Mouse Buttons) -------------------------------------------
*XButton1::MoveWindowPhysicalDirection(1)
*XButton2::MoveWindowPhysicalDirection(-1)

; --- Minimize (Alt + Mouse Buttons) ---
!XButton1::
!XButton2::WinMinimize("A")

; --- Maximize/Restore Toggle (Ctrl + Mouse Buttons) ---
^XButton1::
^XButton2:: {
    activeWin := WinExist("A")
    if !activeWin
        return
    
    if WinGetMinMax(activeWin) = 1
        WinRestore(activeWin)
    else
        WinMaximize(activeWin)
}

MoveWindowPhysicalDirection(direction) {
    Critical ; Prevent thread interruption for faster execution
    activeWin := WinExist("A")
    if !activeWin
        return

    WinGetPos(&x, &y, &w, &h, activeWin)
    minMaxState := WinGetMinMax(activeWin)
    
    monCount := MonitorGetCount()
    if (monCount < 2)
        return

    monitors := []
    loop monCount {
        MonitorGet(A_Index, &left, &top, &right, &bottom)
        monitors.Push({id: A_Index, x: left})
    }

    ; Sort monitors by X coordinate
    for i, mon in monitors {
        for j, nextMon in monitors {
            if (monitors[i].x < monitors[j].x) {
                temp := monitors[i], monitors[i] := monitors[j], monitors[j] := temp
            }
        }
    }

    currentSortedIdx := 1
    loop monitors.Length {
        MonitorGet(monitors[A_Index].id, &left, , &right)
        if (x + w/2 >= left && x + w/2 < right) {
            currentSortedIdx := A_Index
            break
        }
    }

    targetSortedIdx := (targetSortedIdx := currentSortedIdx + direction) > monitors.Length ? 1 : (targetSortedIdx < 1 ? monitors.Length : targetSortedIdx)

    MonitorGet(monitors[currentSortedIdx].id, &cLeft, &cTop)
    MonitorGet(monitors[targetSortedIdx].id, &tLeft, &tTop)

    ; Optimization: Use BatchLines equivalent and direct move
    if (minMaxState = 1) {
        ; Lock window updates to reduce flickering
        SendMessage(0x000B, 0, 0, activeWin) ; WM_SETREDRAW = false
        WinRestore(activeWin)
        WinMove(x - cLeft + tLeft, y - cTop + tTop, , , activeWin)
        WinMaximize(activeWin)
        SendMessage(0x000B, 1, 0, activeWin) ; WM_SETREDRAW = true
        WinRedraw(activeWin)
    } else {
        WinMove(x - cLeft + tLeft, y - cTop + tTop, , , activeWin)
    }
}

^+w::WinClose("A")

; Ensure the following hotkeys only work when Brave is active
#HotIf WinActive("ahk_exe brave.exe")
; Shift + Mouse Button 5 (Back) -> Next Tab
+XButton1:: {
    Send "^{PgDn}"
}
; Shift + Mouse Button 4 (Forward) -> Previous Tab
+XButton2:: {
    Send "^{PgUp}"
}
#HotIf
