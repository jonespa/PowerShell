$ops1 = get-mailbox -database db-operations01
$ops2 = $ops1 | get-user
$ops3 = $ops2.samaccountname | get-aduser
$ops4 = $ops3 | get-adobject -properties lastlogon | sort-object -property lastlogon -descending

new-item -type file -path c:\users\odonir\desktop\logoncheck.txt
$log = get-item c:\users\odonir\desktop\logoncheck.txt


foreach ($user in $ops4)
{
if ($user.lastlogon -gt 0)
	{
	$time = $user.lastlogon
	$dt = [DateTime]::FromFileTime($time)
	add-content $log "$user.name last logged on at $dt"
	}
Else
	{
add-content $log "$user.name has never logged on" 
	}

}