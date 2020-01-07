#########################IMPORTANT: THIS SCRIPT REQUIRES THE NTFS SECURITY MODULE. Use 'install-module NTFSSECURITY' from a PS prompt.##########################

#SETTINGS - edit these.
$folderlist = get-content c:\usr\bin\FolderList.txt # full path of a .txt file containing a list of folder names
$folderlist = $folderlist.trim()  # trim any whitespace
$roparentacl = "acl_team_intel_ro" # set this to the read-only acl of the parent folder, i.e. ACL_FIRMSHARE_FIRMMI_RO
$aclprefix = "ACL_TEAM_intel_" # Set this to the desired prefix of the ACL name, i.e. ACL_FIRMSHARED_FIRMMI_DR_
$rolprefix = "ROL_Intel_"
$path = "\\horwichfarrelly.com\teams$\INTEL" # set to the path of the parent folder
#$path = "c:\users\odonir\desktop\teamacltest" # set to the path of the parent folder
$ADPath = "OU=INTEL,OU=Team ACL,OU=ACL Groups,OU=Rule Groups,OU=Groups,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com" # set to the AD location , i.e. "Orrelly - Proposed New StrU=Horwich Faucture ,DC=horwichfarrelly,DC=Com"
#$ADPath = "OU=Testing,DC=horwichfarrelly,DC=com" # set to the AD location , i.e. "OU=Horwich Farrelly - Proposed New Structure ,DC=horwichfarrelly,DC=Com"



##SCRIPT: Don't mess with this bit.
import-module ntfssecurity # import the ntfs security module.

foreach ($folder in $folderlist){ #begin do loop, select one item at a time from the chosen txt file.
new-item -path $path -itemtype directory -name $folder #create the new folder
$tlpath = "$path\$folder"
new-item -path $tlpath -itemtype directory -name "Team Leader"
$roaclname = -join ($aclprefix, $folder, "_ro") #generate the acl name string for read only
$rwaclname = -join ($aclprefix, $folder, "_rw") # generate the acl name string for read/write
$tlroaclname = -join ($aclprefix, $folder, "_tl_ro")
$tlrwaclname = -join ($aclprefix, $folder, "_tl_rw")
$rolname = -join ($rolprefix, $folder)
$tlrolname = -join ($rolprefix, $folder, "_TL")
new-ADgroup -name $roaclname -SamAccountName $roaclname -GroupCategory Security -GroupScope Global -DisplayName $roaclname -Path "$ADPath" #generate the RO group in AD 
new-ADgroup -name $rwaclname -SamAccountName $rwaclname -GroupCategory Security -GroupScope Global -DisplayName $rwaclname -Path "$ADPath" #generate the RW group in AD
new-ADgroup -name $tlroaclname -SamAccountName $tlroaclname -GroupCategory Security -GroupScope Global -DisplayName $tlroaclname -Path "$ADPath" #generate the RO group in AD 
new-ADgroup -name $tlrwaclname -SamAccountName $tlrwaclname -GroupCategory Security -GroupScope Global -DisplayName $tlrwaclname -Path "$ADPath" #generate the RO group in AD
new-ADgroup -name $rolname -SamAccountName $rolname -GroupCategory Security -GroupScope Global -DisplayName $rolname -Path "$ADPath" #generate the RO group in AD 
new-ADgroup -name $tlrolname -SamAccountName $tlrolname -GroupCategory Security -GroupScope Global -DisplayName $tlrolname -Path "$ADPath" #generate the RW group in AD 
start-sleep 10  # pause 5 seconds for AD to update
Add-ADGroupMember -identity $roaclname -members $rwaclname # add write group into read group
Add-ADGroupMember -identity $roparentacl -members $roaclname # add read group into the parent read group
Add-ADGroupMember -identity $tlroaclname -members $tlrwaclname # add write group into read group
Add-ADGroupMember -identity $roaclname -members $tlroaclname # add read group into the parent read group
Add-ADGroupMember -identity $rwaclname -members $rolname # add read group into the parent read group
Add-ADGroupMember -identity $tlrwaclname -members $tlrolname # add read group into the parent read group
add-ntfsaccess -path "$path\$folder" -account horwichfarrelly\ADM_NTFSMGR -accessrights Fullcontrol -AppliesTo ThisFolderSubfoldersandfiles #set ADM_NTFSMGR to full control over the folder
add-ntfsaccess -path "$path\$folder" -account system -accessrights Fullcontrol -AppliesTo ThisFolderSubfoldersandfiles #set ADM_NTFSMGR to full control over the folder
add-ntfsaccess -path "$path\$folder" -account horwichfarrelly\$roaclname -accessrights readandexecute -AppliesTo ThisFolderSubfoldersandfiles # set read access to the RO group
add-ntfsaccess -path "$path\$folder" -account horwichfarrelly\$rwaclname -accessrights modify -AppliesTo ThisFolderSubfoldersandfiles # set write access to the Write group
add-ntfsaccess -path "$tlpath\Team Leader" -account horwichfarrelly\ADM_NTFSMGR -accessrights Fullcontrol -AppliesTo ThisFolderSubfoldersandfiles #set ADM_NTFSMGR to full control over the folder
add-ntfsaccess -path "$tlpath\Team Leader" -account system -accessrights Fullcontrol -AppliesTo ThisFolderSubfoldersandfiles #set ADM_NTFSMGR to full control over the folder
add-ntfsaccess -path "$tlpath\Team Leader" -account horwichfarrelly\$tlroaclname -accessrights readandexecute -AppliesTo ThisFolderSubfoldersandfiles # set read access to the RO group
add-ntfsaccess -path "$tlpath\Team Leader" -account horwichfarrelly\$tlrwaclname -accessrights modify -AppliesTo ThisFolderSubfoldersandfiles # set write access to the Write group
Disable-NTFSAccessInheritance -Path "$path\$folder" -RemoveInheritedAccessRules # disables inheritance on the folder
Disable-NTFSAccessInheritance -Path "$tlpath\Team Leader" -RemoveInheritedAccessRules # disables inheritance on the folder
write-host "$folder created" # output to the console
}