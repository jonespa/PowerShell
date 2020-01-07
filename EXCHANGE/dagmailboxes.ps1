$leg1 = get-mailbox -database hf-dag1-it
$leg2 = get-mailbox -database hf-dag1-operations
$fee1 = get-mailbox -database hf-dag1-claimshandlers
$fee2 = get-mailbox -database hf-dag1-servicemb
$fee3 = get-mailbox -database hf-dag1-sharedmb
$ops1 = get-mailbox -database hf-dag1-secretarialsupport
$serv1 = get-mailbox -database hf-dag1-legalsupport
$serv2 = get-mailbox -database hf-dag1-fee-earners
$leav = get-mailbox -database hf-dag1-leavers
$total = $leg1.length + $leg2.length + $fee3.length + $fee1.length + $fee2.length + $ops1.length + $serv1.length + $serv2.length+$leav.length


write-host "hf-dag1-it contains" $leg1.length "mailboxes"
write-host "hf-dag1-operations contains" $leg2.length "mailboxes"
write-host "hf-dag1-claims-handlers contains" $fee1.length "mailboxes"
write-host "hf-dag1-servicemb contains" $fee2.length "mailboxes"
write-host "hf-dag1-sharedmb contains" $fee3.length "mailboxes"
write-host "hf-dag1-secretarialsupport contains" $ops1.length "mailboxes"
write-host "hf-dag1-legalsupport contains" $serv1.length "mailboxes"
write-host "hf-dag1-fee-earners contains" $serv2.length "mailboxes"
write-host "hf-dag1-leavers contains" $leav.length "mailboxes"
write-host "total mailboxes in the DAG is $total"
