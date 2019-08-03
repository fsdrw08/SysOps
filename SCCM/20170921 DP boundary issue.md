20170921; 1500097566; Lu, Shuxin; User cannot download software Efficient Elements from Software Center, error code: 0x87D00607:

Base on the error code, it's a boundary problem,

1. Check user computer subnet: user computer name: SZX-D69BSF2; IP: 172.17.225.17; check from AD Site and Services\Subnets, user's computer stay at CN-SZX site subnet; 

2. Check site / IP range's site systems belongs to: open SCCM console, go to \Administration\Overview\Hierarchy Configuration\Boundaries > click search > type "SZX" > right click "CN-SZX" - "Properties" > "Site Systems" > found that the site / IP range Site System belongs to APP-SZXSCCM02.COMPANY.COM.CN; 

3. Check software deployment status: open SCCM console, go to \Software Library\Overview\Application Management\Applications > click search blank > in the search tab, click "All Subfolders" > type "Efficient Elements" and search > right click "Efficient Elements for presentations - LITE Edition" - properties > Content Locations, found that the site system "APP-SZXSCCM02.COMPANY.COM.CN" is not here | Cancel; 

4. Distribute content to the distribute point: right click "Efficient Elements for presentations - LITE Edition" - "Distribute Content" > General - "Next" > Content - "Next" > "Content Destination" - "Add" - "Distribution Group" - select "APP-SZXSCCM02.COMPANY.COM.CN" - "Next" > …, wait for the distribute complete.

Let user try again, done.
