#http://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
param (
    [string]$server = "http://defaultserver",
    [string]$username = $(throw "-username is required."),
    [string]$password = $( Read-Host "Input password, please" )
 )

 Write-Host "Server = $server, username = $username, password = $password"

 # Usage [scriptName] -server "myServer" -username "user1!" -password "pwd"