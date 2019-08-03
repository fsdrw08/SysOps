20161228; the desktop for print paylist at canteen do not want to lanuch screen saver:

• Principle: 
        Create a group and add the target computer in this group, go to GPO and select the policy which set with the screen saver, add this group, and set denny Read and denny Apply group policy permissions for this group.

• Operation: 

  1. Remote logon app-fuobgadm01, start > ADUC > go to company.com.cn\!FS\!Computers\ > Action - New - Organizational Unit, name: Without_OCN_GPO > open this OU; Action - New - Group; Group name: Without_OCN_GPO; Group scope: Global; Group type: Security; Members: Add FSD9006222796, FUO-D00143; OK.  
        
  2. Start | type and launch "Group Policy Management" > Group Policy Management\Forest: company.net\Domains\company.com.cn\!FS\OCN_Policy > Delegation > Add > Without_OCN_GPO; OK > Advanced... > select Without_OCN_GPO, Permissions for Without_OCN_GPO > Read – Deny; Apply group policy – Deny; OK.  
        
  3. Remote logon the target computer by local administrator > Start > type and launch "CMD" > type and enter "gpupdate /force" > go to Control Panel\Appearance and Personalization\Personalization\Screen Saver, uncheck the "On resume, display logon screen" check box.
