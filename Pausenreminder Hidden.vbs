Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -WindowStyle Hidden -File ""C:\path\to\your\script.ps1""", 0, False
