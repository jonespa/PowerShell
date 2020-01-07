$mb1 = get-mailbox -database DB-legal-support01							#get all mbs in LS2
$mbs1 = foreach ($mb in $mb1) {get-mailboxstatistics -identity $mb} 				#get the mailbox stats for the mb1 list - since get-mailboxstats gives incorrect list
$LS1 = $mbs1 | where {$_.totalitemsize -lt 2GB} | get-mailbox 					#create a list containing only <2GB mailboxes for LS
$mb2 = get-mailbox -database DB-fee-earners01							#get all mbs in LS2
$mbs2 = foreach ($mb in $mb2) {get-mailboxstatistics -identity $mb} 				#get the mailbox stats for the mb1 list - since get-mailboxstats gives incorrect list
$LS2 = $mbs2 | where {$_.totalitemsize -lt 2GB} | get-mailbox 					#create a list containing only <2GB mailboxes for LS
    
$i = 0 												#iterator set to zero
$l = -1												#limiter, multiply by i for time limit. i = 15 minutes, so 48 = 12 hours. Set to -1 for limitless.

Foreach ($mailbox in $LS1)  									#open a loop
{
new-moverequest -identity $mailbox -targetdatabase "HF-DAG1-legalsupport" 			#move to Ops DB
$i = $i+1 											#increase iterator
start-sleep 900 										#wait 15 minutes
$date = date 											#get current time
write-host "Migrated $mailbox to HF-DAG1-LS at $date" 						#write to the console
if ($i -eq $l) 											#check if the limit is reached
{break} 											#if yes, break the loop
}
Foreach ($mailbox in $LS2)  									#open a loop
{
new-moverequest -identity $mailbox -targetdatabase "HF-DAG1-fee-earners" 			#move to Ops DB
$i = $i+1 											#increase iterator
start-sleep 900 										#wait 15 minutes
$date = date 											#get current time
write-host "Migrated $mailbox to HF-DAG1-FEs at $date" 						#write to the console
if ($i -eq $l) 											#check if the limit is reached
{break} 											#if yes, break the loop
}
