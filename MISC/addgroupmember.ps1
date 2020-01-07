$a = get-adcomputer -Filter * -Properties whencreated| Where-Object {$_.samaccountname -like "LT*" }
$b = get-adcomputer -Filter * -Properties whencreated| Where-Object {$_.samaccountname -like "WIN7*" }
$c = get-adcomputer -Filter * -Properties whencreated| Where-Object {$_.samaccountname -like "WIN10*" }
$d = $a+$b+$c

$d = $d | Where-Object {$_.whencreated -ge ((get-date).adddays(-1)).date}

Add-ADGroupMember -Identity "HF - All User Systems" -Members $d