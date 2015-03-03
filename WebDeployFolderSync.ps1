# Syncs folders using Web Deploy the manifest command

# Syncing folders using Web Deploy requires the ContentPath provider. There is no PowerShell command for this provider out of the box so you have to use the manifest command. The script will create all the config files required including the source manifest, destination manifest and the destination publish settings file.

# Further reading
# https://technet.microsoft.com/en-us/library/dd569104(v=WS.10).aspx
# http://www.iis.net/learn/publish/using-web-deploy/web-deploy-powershell-cmdlets

# Usage
# .\WebDeployFolderSync.ps1 -username "someusername" -password "password123" -sourceFolder "D:\source\" -destinationServer "https://someurl:1234/msdeploy.axd" -destinationFolder "D:\destination`stuff\" -description "MyServer"

param (
    [string]$username = $(throw "-username is required."),
    [string]$password = $(throw "-password is required."),
    [string]$sourceFolder = $(throw "-sourceFolder is required."),
    [string]$destinationServer = $(throw "-destinationServer is required."),
    [string]$destinationFolder = $(throw "-destinationFolder is required."),
    [string]$description = $(throw "-description is required.")
 )

 function CreateManifestFile($sourceFolder, $filePath) 
{
    $xmlDocument = New-Object System.XML.XMLDocument

    $root = $xmlDocument.CreateElement("uploadManifest")

    $xmlDocument.appendChild($root)

    $contentPath = $root.appendChild($xmlDocument.CreateElement("contentPath"))

    $contentPath.SetAttribute("path", $sourceFolder)

    $xmlDocument.Save($filePath)
}


Add-PSSnapin WDeploySnapin3.0

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
$sourceManifestFile = $(Convert-Path .) + "\" + $description + "SourceManifest.xml"
$destinationManifestFile = $(Convert-Path .) + "\" + $description + "DestinationManifest.xml"
$settingsFile = $(Convert-Path .) + "\" + $description + ".settings"

CreateManifestFile $sourceFolder $sourceManifestFile
CreateManifestFile $destinationFolder $destinationManifestFile

New-WDPublishSettings -ComputerName $destinationServer -Credentials $credentials -AllowUntrusted -FileName $settingsFile

Sync-WDManifest -SourceManifest $sourceManifestFile -DestinationManifest $destinationManifestFile -DestinationPublishSettings $settingsFile -Verbose

