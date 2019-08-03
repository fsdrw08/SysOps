20180425; User report that after migration, he cannot printo out SAP jobs via the local printer: 

• Background: 

The printer is connected to user's computer by external LAN, in the old days, COMPANY IT shared this printer to server INF-HKPSCCM01.COMPANY.COM.HK via user computer's VPN, treat the printer as a "intranet" printer to aviod site to site VPN set up from local, but after migration, this printer cannot print out (receive print order) from intranet anymore.

• Solution: 

Run the printer set up process again;
        
1. Remote control user's computer HKP-N00003: 

a. Go to "Control Panel\Programs\Programs and Features\" Turn on Windows feature, ensure that "Print and Document Services\LRD Print Service, LPR Port Monitor"  are already turned on;

b. Open "services", ensure that the "LPD Service" are running (important, if this service not run, the operation in server site will not work);

c. Connect the local printer, share it, name it to "CHX2", if it shows “Unable to install printer. Another printer or printers share with this name already exists. please use another name for the printer.”, open regedit, go to "Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\" delete the registry key thathas the value of the printer name you were trying to use (CHX2), then re-try to name the local printer to "CHX2".

2. Remote login Hong Kong printer server INF-HKPSCCM01.COMPANY.COM.HK:

a. Go to "Control Panel\Hardware\Devices and Printers", remove the original CHX2 printer,

b. Open Print Management, go to "Print Servers\Printers", delete the CHX2, if cannot delete, just run the regedit to delete the printer name key; go to "Print Servers\Ports", delete the port "HKP-N00003:CHX2";

c. Open Print Management, go to "Print Servers\Ports" > Action > add port… > select LPR Port; new Port… > Name or address of server providing lpd: HKP-N00003; Name of printer or print queue on that server: CHX2; OK.

d. Go to "Control Panel\Hardware\Devices and Printers",  Add a local printer or network printer with  manual settings by the port “HKP-N00003:CHX2", select relate printer driver, done.
