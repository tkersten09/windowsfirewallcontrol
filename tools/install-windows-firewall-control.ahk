#SingleInstance ; Ensure only one instance at a time
#Persistent ; Ensure the script persists until an ExitApp
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Mouse, Client ; All used coordinates are now relative to the upper left corner of the active Window and thus should work for everyone.

WinWaitActive, Windows Firewall Control
Click, left, 440, 294 ; presses the next button to start the Installation.
WinWaitActive, Windows Firewall Control
; Tries to press the Exit Button until the Window of the Installer is not present anymore. The Exit Button appears when the Installation is completed successfully.
While(WinExist("Windows Firewall Control")){
	Click, left, 452, 294
	Sleep 200
}
ExitApp