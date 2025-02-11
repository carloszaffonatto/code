$source = "\\192.168.0.0\Folder"
$destination = "\\192.168.0.0\Folder"
$logFile = "C:\logs\copylog.txt"

Write-Host "Copying files from $source to $destination" -ForegroundColor Cyan

robocopy $souce $destination /e /zb /xx /mov /log:logFile /tee /mt:8 /bytes /eta

Write-Host "File copy complete." -ForegroundColor Green

$title = "File copy Completed"
$message = "Files Transferred"
$priority = 7

#make some huma friendly names
$copy = 'TOKEN' #Tokens from user crated app

#call
$usertokens = $copy

foreach ($usertoken in $usertokens) {
    $json = @{
          "message"="$message"
          "priority"=$priority
          "title"="$title"
    } | ConvertTo-Json

Invoke-RestMethod -Url "https://.com/message?token=$usertoken" -Method Post -Body $json -ContentType "application/json"
}
