# Check out a SVN repository
$svnExe = "$env:programfiles\TortoiseSVN\bin\SVN.exe"

# Required
$repositoryUrl = "https://repo location"
$checkoutPath = "C:\some checkout location"

# & = run command. --quiet won't tell you about each file being checked out
& $svnExe checkout --quiet $repositoryUrl $checkoutPath