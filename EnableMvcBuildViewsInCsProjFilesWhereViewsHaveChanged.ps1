
# This is run as a TeamCity build step
# In TeamCity create a PowerShell build step then
# - Set "Script execution mode" to "Execute .ps1 script with -File argument"
# - Set "Script arguments" to "%system.teamcity.build.changedFiles.file% %teamcity.build.workingDir%"
$changedFileInfoPath = $args[0]
$workingDirectory = $args[1]

# Got this function from http://suhinini.blogspot.co.uk/2010/02/using-xmlpeek-and-xmlpoke-in-powershell.html
function xmlPoke($file, $xpath, $value) 
{
	$filePath = $file.FullName

	[xml] $fileXml = Get-Content $filePath
	$node = $fileXml.SelectSingleNode($xpath)
	if ($node) 
	{
		$node.InnerText = $value

		$fileXml.Save($filePath)
	}
}

####### Step 1 - Reset all csproj files first because TeamCity doesn't do a clean checkout unless you have checked that option https://confluence.jetbrains.com/display/TCD8/Build+Checkout+Directory
$allWebCsProjFiles = Get-ChildItem -Path $workingDirectory -Recurse -Include "*.csproj"

write-host "##teamcity[message text='Reseting all csproject files...']"
foreach ($csProjFile in $allWebCsProjFiles)
{
    xmlPoke $csProjFile "//*[local-name()='MvcBuildViews']" "false"
    write-host "##teamcity[message text='Reset MvcBuildViews to false in $csProjFile']"
}


####### Step 2 - Get information about changed views
$changedFileData = Get-Content $changedFileInfoPath 

$csProjFilesToEnableBuildViews = @()

write-host "##teamcity[message text='Looking for view changes...']"
foreach($line in $changedFileData)
{
    if($line -like "*.cshtml*")
	{
        # Line format [fileName]:[status]:[commitHash]
        # E.g. Home/Index.cshtml:CHANGED:1400ea14c3196abbfd8de3ab6fe0a902be2ccad8

        $lineBits = $line -split ":"
        $fileNameChanged = $lineBits[0]        

        write-host "##teamcity[message text='View change found $fileNameChanged']"

        $csProjRoot = $fileNameChanged -match "(.*/)Views/.*"
        $csProjDirectory = join-path -path $workingDirectory -childpath $matches[1]
 
        $csProjToChange = Get-ChildItem -Path $csProjDirectory -Recurse -Include "*.csproj"

        $csProjFilesToEnableBuildViews += $csProjToChange
	}
}


####### Step 3 - Set MvcBuildViews to true in all changed projects
if ($csProjFilesToEnableBuildViews.Length -gt 0)
{
    $uniqueCsProjFilesToEnableBuildViews = $csProjFilesToEnableBuildViews | select -Unique 

    write-host "##teamcity[message text='Poking csproj files...']"
	foreach ($csProjFile in $uniqueCsProjFilesToEnableBuildViews)
	{
		xmlPoke $csProjFile "//*[local-name()='MvcBuildViews']" "true"
		write-host "##teamcity[message text='Set MvcBuildViews to true in $csProjFile']"
	}
}
else
{
    write-host "##teamcity[message text='No view changes found']"
}