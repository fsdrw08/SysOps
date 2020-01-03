•	Issue description: 

Some user complain that Skype for Business (SfB) client cannot show up scheduled meetings which already show in outlook calendar

•	Investigation: 

Found that from external network, the SfB client do show up scheduled meetings, but it don’t for internal network. 

Regarding to this link http://www.uclabs.blog/2013/01/lync-and-exchange-web-services-ews-and.html
 
To check more details, click ctrl + SfB icon (on the tray bar) ->“Configuration Information”. 
Found that here is the interesting different item between internal and external network for SfB client:
 
| 	              |External network|	Internal network|
|-----------------|----------------|------------------|
|EWS Internal URL |                |                  |
|EWS External URL	|https://webmail.company.com/ews/exchange.asmx| |
|EWS Information	|EWS Status OK   |EWS not deployed  |
 
Assume that EWS(Exchange Web Service) connection can get calendar from exchange server. 
EWS connection require DNS record “autodiscover.domain.name” to connect to the exchange server, check DNS from external,
there are DNS records for company: 
```powershell
Resolve-DnsName autodiscover.company.com
```
|Name                     |Type|TTL|Section|IPAddress|
|-------------------------|----|---|-------|---------|
|autodiscover.company.com | A  |300|Answer|xxx.xxx.xxx.149|
|autodiscover.company.com | A  |300|Answer|xxx.xxx.xxx.6|

But for internal network, there is no such DNS record, so, what we need to do, is add DNS record in internal DNS server.

•	Solution:

Regarding to the network config, open DNS console and connect to internal DNS management server, Forward lookup zoom -> right click “company.com” -> New Alias -> 
Alias Name: Autodiscover
FQDN for target host: webmail.company.com
-> ok. 
Few minutes later, verify the DNS setting:

•	Result:

Scheduled meetings will show up in internal SfB client. Problem fixed.

