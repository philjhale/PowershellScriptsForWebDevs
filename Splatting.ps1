# https://blogs.endjin.com/2013/05/powershell-best-kept-secrets-splatting/


Function DoSomething 
{ 
    Param
    (
        [string] $Name, 
        [string] $Description,
        [string] $Status
    )

    Write-Host "$Name - $Description - $Status"
}

$parameters = @{
    Name = "Phil"
    Description = "things"
    Status = "some status"
}


DoSomething @parameters