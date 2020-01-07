$a = get-childitem -recurse "\\hffs01\it\archive\AdmiralSFTP" -file
$b = get-childitem -recurse "\\2012DC1\fee\New Files - Defendant\EUI Lit" -file
$list1 = @($a.name)
$list2 = @($b.name)
foreach ($file in $list2)															# take each item from dc2012, one at a time
{
if ($list1 -contains $file)													
{ 
$b| where {$_.name -like $file } | remove-item
}
}