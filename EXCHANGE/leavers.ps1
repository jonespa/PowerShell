$mb1 = get-mailbox -database DB-LEAVERS								#get all mbs in LS2

    
$i = 0 												#iterator set to zero
$l = -1 											#limiter, multiply by i for time limit. i = 15 minutes, so 48 = 12 hours. Set to -1 for limitless.

Foreach ($mailbox in $mb1)  									#open a loop
{
new-moverequest -identity $mailbox -targetdatabase "HF-DAG1-LEAVERS" 				#move to Ops DB
$i = $i+1 											#increase iterator
start-sleep 900 										#wait 15 minutes
$date = date 											#get current time
write-host "Migrated $mailbox to HF-DAG1-LEAVERS at $date" 					#write to the console
if ($i -eq $l) 											#check if the limit is reached
{break} 											#if yes, break the loop
}