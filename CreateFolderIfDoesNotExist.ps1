if(-Not (Test-Path -Path "C:\Temp"))
{
	New-Item "C:\Temp" -type directory
}