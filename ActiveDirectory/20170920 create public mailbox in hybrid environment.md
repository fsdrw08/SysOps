20170920; User needs to create a public mailbox:

Best practices: 

> 1. Create a user account (for public mailbox) from AD, set special attribute for trigger cloud synchronize ;
> 2. Create the shared mailbox for this account from on-premise exchange 2013 server, add this account to some permission group(important, only exchange mailbox account create from on-premise exchange server can add to the permission group which create from on-premise exchange server), assign full access permission to user.
