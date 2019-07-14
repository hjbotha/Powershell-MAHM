ScriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
command = "powershell.exe -nologo -command " & scriptdir & "\Powershell-Collect.ps1"
 set shell = CreateObject("WScript.Shell")
 shell.Run command,0