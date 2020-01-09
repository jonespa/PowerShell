function Get-ADPrincipalGroupMembershipRecursive( ) {

   Param(
       [string] $dsn, 
       [array]$groups = @()
   )

   # Get an ADObject for the account and retrieve memberOf attribute.
   $obj = Get-ADObject $dsn -Properties memberOf

   # Iterate through each of the groups in the memberOf attribute.
   foreach( $groupDsn in $obj.memberOf ) {

       # Get an ADObject for the current group.
       $tmpGrp = Get-ADObject $groupDsn -Properties memberOf

       # Check if the group is already in $groups.
       if( ($groups | where { $_.DistinguishedName -eq $groupDsn }).Count -eq 0 ) {

           $groups +=  $tmpGrp

           # Go a little deeper by searching this group for more groups.
           $groups = Get-ADPrincipalGroupMembershipRecursive $groupDsn $groups
       }
   }

   return $groups

}

$aduser = get-aduser prestonr #get ad object relating to the user in question
$groups   = Get-ADPrincipalGroupMembershipRecursive ($aduser).DistinguishedName
$groups.count