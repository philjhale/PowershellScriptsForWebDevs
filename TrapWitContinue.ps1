Trap {
  Write-Host "Error happened - $_"
  Continue # Could also use $ErrorActionPreference = "SilentlyContinue"
}

Write-Host "Starting script"

$i = $i / 0

Write-Host "This will be shown because of the Continue statement"