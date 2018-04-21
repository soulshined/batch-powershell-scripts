REM Author          David Freer [soulshined@me.com]
REM Build Date      4/20/2017
REM Version         1.0

' This program runs the downloads-organizer.cmd file as a hidden task
' This assumes they are in the same directory

DIM fo
Set fo = CreateObject("Scripting.FileSystemObject")

If (fo.FileExists("downloads-organizer.cmd")) Then
  Set objShell = WScript.CreateObject("WScript.Shell")
  objShell.Run "downloads-organizer.cmd ", 0, false
End If
