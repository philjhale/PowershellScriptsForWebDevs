# Unzips a zip file. Heavily based on this script http://www.howtogeek.com/tips/how-to-extract-zip-files-using-powershell/

function CreateFolderIfDoesNotExist($filePath)
{
    if(-Not (Test-Path -Path $filePath))
	{
		New-Item $filePath -type directory
	}
}

function ExpandZipFile($zipFilePath, $unzipDestination)
{
    CreateFolderIfDoesNotExist $unzipDestination

	$shell = new-object -com shell.application

	$zip = $shell.NameSpace($zipFilePath)
	
	$shell.Namespace($unzipDestination).CopyHere($zip.Items())
}

# Required
$zipFilePath = "C:\path to zip"
$unzipDestination = "C:\path to unzip folder"

ExpandZipFile $zipFilePath $unzipDestination