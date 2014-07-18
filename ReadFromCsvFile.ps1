# Outputs data from a CSV file

# CSV format
# Name,Department,Title
# Pilar Ackerman,Research,Manager
# Jonathan Haas,Finance,Finance Specialist

# Required
$path = "C:\path toExampleCsvFile.csv"

$fileData = Import-Csv $path

Foreach ($row in $fileData)
{
    Write-Host $row.Name $row.Department $row.Title
}