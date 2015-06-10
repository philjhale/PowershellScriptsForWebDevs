Trap {
  Write-Host "Error happened - $_"
  Break # Could also use $ErrorActionPreference = "Stop"
}

Write-Host "Starting script"

$i = $i / 0

Write-Host "This shouldn't be shown because of the Break statement"