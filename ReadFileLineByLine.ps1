$fileName = "C:\install.log"

$a = Get-Content $fileName

foreach($line in $a)
{
    write-host $line
}
