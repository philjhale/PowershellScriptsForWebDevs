# Creates HipChat users from a csv file

# Mainly cobbled together from https://github.com/lholman/hipchat-ps/blob/master/Publish-HipChatRoomMessage.psm1 and http://technet.microsoft.com/en-us/library/hh849971.aspx

# Text file like this
#Email,Name,Mention_name,Title
#Philip.Hale@email.com,Philip Hale,PhilipHale,Job Title
#Joe.Bloggs@email.com,Joe Blogs,JoeBlogs,Job Title

# Required 
$apitoken = ""
$csvPath = "C:\path to\ExampleCsvFile.csv"
$password = ""

function CreateUser($email, $name, $mentionName, $title)
{
    $url = "https://api.hipchat.com/v1/users/create"

    $body = @{
        auth_token = $apitoken
        email = $email
        name = $name
        mention_name = $mentionName
        title = $title
        password = $password
    }

    Invoke-RestMethod -Method Post -Uri $url -Body $body

    Write-Host "Created user $name"
}

$fileData = Import-Csv $csvPath

Foreach ($row in $fileData)
{
    CreateUser $row.Email $row.Name $row.Mention_name $row.Title
    Start-Sleep -s 4 #https://www.hipchat.com/docs/api/rate_limiting
}