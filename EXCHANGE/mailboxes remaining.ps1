$leg1 = get-mailbox -database db-legal-support01
$fee1 = get-mailbox -database db-fee-earners01
$serv1 = get-mailbox -database db-service-mailboxes01
$shar1 = get-mailbox -database db-shared-mailboxes01
$eq1 = get-mailbox -database db-equity-partners01
$eq2 = get-mailbox -database db-equity-partners02
$total = $leg1.length + $fee1.length + $fee2.length + $serv1.length + $serv2.length + $shar1.length + $shar2.length + $eq1.length + $eq2.length
$1tot = $leg1.length + $fee1.length + $serv1.length + $shar1.length + $eq1.length 
$2tot = $eq2.length

write-host "DB-legal-support01 contains" $leg1.length "mailboxes"
write-host "db-fee-earners01 contains" $fee1.length "mailboxes"
write-host "db-fee-earners02 contains" $fee2.length "mailboxes"
write-host "db-service-mailboxes01 contains" $serv1.length "mailboxes"
write-host "db-service-mailboxes02 contains" $serv2.length "mailboxes"
write-host "db-shared-mailboxes01 contains" $shar1.length "mailboxes"
write-host "db-shared-mailboxes02 contains" $shar2.length "mailboxes"
write-host "db-equity-partners01 contains" $eq1.length "mailboxes"
write-host "db-equity-partners02 contains" $eq2.length "mailboxes"
write-host "total remaining mailboxes outside DAG is $total"
write-host "Mailboxes on HFexch01 is $1tot"
write-host "mailboxes on hfexch02 is $2tot"