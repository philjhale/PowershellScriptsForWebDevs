# Send deployment event to New Relic

# A more sophisticated version of this script is available here
# http://blogs.endjin.com/2014/07/create-a-custom-teamcity-powershell-metarunner-to-notify-newrelic-that-new-deployment-has-occurred/

# Required
$apiKey = ""
$applicationId = ""

$url = "https://api.newrelic.com/deployments.xml"
$headers = @{"x-api-keyù"=$apiKey}

$body = "deployment[application_id]=$applicationId"

Invoke-RestMethod -Method Post -Uri $url -Body $body -Headers $headers