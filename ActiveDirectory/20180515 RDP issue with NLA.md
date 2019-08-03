20180515; User report that the vendor cannot use account: company\sys_cnsmarthr login to server DBM-FUO10:

• Background: 

The company AD group policy already deploy to all computer that: Allow connections only from computers running Remote Desktop with Network Level Authentication (NLA), in other words, all RDP connections account should be the domain accounts. And we had add some servers in "Lon on to.." with AD account company\sys_cnsmarthr, but after that, we still cannot remote desktop connect to those servers which we had set up in "Log on to…", error when RDP:"The system administrator has limited the computers you can log on with." 

• Solution: 

Add the client computer name in that account's "Log on to.." computer list.

There is a bug in NLA.

https://social.technet.microsoft.com/Forums/ie/en-US/05c066a1-b2f7-4389-8b39-191d14bde62d/adattribute-userworkstations-is-ignored-in-2012r2

https://www.urtech.ca/2016/01/solved-rdp-the-system-administrator-has-limited-the-computers-you-can-log-on-with-log-on-to/
