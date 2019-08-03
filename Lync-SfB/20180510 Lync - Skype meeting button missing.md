20180510; Lync - Skype meeting button missing, Skype meeting add-in is in inactive add-in list, it can be enable, also works then, however, disappears when outlook reopen:

Fixed it by changing the load behavior of skype add-in to allow it to load on startup by changing the value of the below mentioned registry key to 3.

> HKCU\Software\Microsoft\Office\Outlook\AddIns\UCAddin.LyncAddin.1
