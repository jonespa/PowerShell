$name1 = "Odonir"
$name2 = "BentleyA"
$a = get-aduser $name1 | get-adprincipalgroupmembership
$b = get-aduser $name2 | get-adprincipalgroupmembership
$list1 = @($a.name)
$list2 = @($b.name)
Write-host""
Write-host""
write-host "$name1 only in"
foreach ($group in $list1)
{
if ($list2 -notcontains $group)
{ 
write-host $group
}
}
Write-host""
Write-host""
write-host "$name2 only in"
foreach ($group in $list2)
{

if ($list1 -notcontains $group)
{ 
write-host $group
}
}