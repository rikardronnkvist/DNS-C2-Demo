PARAM (
    $demoTextFile = "demo-push-out.txt"
)
Write-Host "Demo - Remote Script"

$userName = (Get-Item ENV:UserName).Value
$userDomain = (Get-Item ENV:UserDomain).Value
$computerName = (Get-Item ENV:ComputerName).Value.Replace("`\", "")
$logonServer = (Get-Item ENV:LogonServer).Value.Replace("`\", "")

$outString = "$($userName);$($userDomain);$($computerName);$($logonServer)"
Write-Host "Information: $($outString)"

$currentDir = Split-Path ((Get-Variable MyInvocation -Scope 0).Value).MyCommand.Path
$demoTextFilePath = Join-Path $currentDir $demoTextFile
Write-Host " Writing to: $($demoTextFilePath)"
$outString | Out-File -FilePath $demoTextFilePath -Force

