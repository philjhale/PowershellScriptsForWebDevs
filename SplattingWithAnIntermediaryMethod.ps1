
function Log
{
 param
    (
        [string] $Test1, 
        [string] $Test2
    )

    Write-Host "Log called Test1 = $Test1 and Test2 = $Test2"
}

function CallTestLog
{
 param
    (
        [string] $SomeParam,
        [hashtable] $CommonLogParams #Pass as hashtable to intermediary method to avoid bloating the number of parameters
    )

    Write-Host "CallTestLog called with param $SomeParam"
    Log @CommonLogParams
}

$commonLogParams = @{
    Test1 = "Test param 1"
    Test2 = "Test param 2"
}

write-host $commonLogParams.Test1


CallTestLog "someparam" $commonLogParams