# Outputs data from a CSV file

# Required
$path = "C:\path to\ReadFromCsvFileExampleFile.csv"

$fileData = Import-Csv $path

Foreach ($row in $fileData)
{
    Write-Host $row.Name $row.Department $row.Title
}