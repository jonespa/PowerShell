Import-Module ActiveDirectory #Imports the AD module which allows the script to connect to and edit Active Directory
$Users = Import-Csv C:\USR\BIN\Users.csv #The source of the new user details - samAccountName, department, etc (lots of options available to add in for creation with account) 
#$Manchester = Import-Csv C:\USR\BIN\Manchester.csv #Contains the group names as defined by the new starter list needed for all users working in the Manchester office
#$London = Import-Csv C:\USR\BIN\London.csv #Contains the group names as defined by the new starter list needed for all users working in the London office
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hfexch01/PowerShell/ -Authentication Kerberos
#Import-PSSession $Session #Imports the Exchange module which allows the script to connect to and edit MS Exchange

ForEach ($User in $users) {
$pwd = “test12523215A”,”a1foi[ghf”,”Xz1;Y678” | GET-RANDOM 
$pwd2 = $pwd | ConvertTo-SecureString -AsPlainText -Force
$global:InitialNumber = 0
$global:samAccountName = "$($User.Lastname)$($User.FirstName[$InitialNumber])"
$name = "$($User.FirstName) $($User.LastName)"

$LoopError = "The specified account already exists" 
do { #start of a loop to catch any errors from samAccountName duplication i.e. smithj and then another person with j as the firstname initial and Smith as surname starting
$b = 1 #start of the logical argument

    Try { #attempt to create the account, if the account does already exist, it will get caught in the "catch" below
        New-ADUser -path "OU=No Policy,DC=horwichfarrelly,DC=com" -SamAccountName $samAccountName -AccountPassword $pwd2 -Company "Horwich Farrelly" -Department $user.Department -DisplayName "$($User.FirstName) $($User.LastName)" -GivenName $User.FirstName -Surname $User.LastName -Initials $User.Initials -HomePhone $User.ExtNumber -OfficePhone "0161 413 $($User.ExtNumber)" -Title $User.JobTitle -Office $User.Office -Name $name
        }
    Catch [Microsoft.ActiveDirectory.Management.ADIdentityAlreadyExistsException] { #The catch will initiate an increment of firstname initial inclusion i.e. add on the next letter in the firstname as part of the asmAccountName
        Switch ($_.Exception.Message) {
            "The specified account already exists"            
                {$InitialNumber ++
                $sam2 = $User.FirstName[$InitialNumber] #This line gets the next letter incremented in the firstname
                                                                $name = "$($User.FirstName) $($User.LastName)"+"$InitialNumber"
                                                                
                $global:samAccountName = -join ($samAccountName, $sam2) #This line joins the two variable results together
                                                                
                $b = 2 #This is the logical arguement result that will continue the loop i.e. because its 2 not 1, it will continue until its created a unique samAccountName and then drop out of the loop
            }
            Default {
            $_.Exception.Message
            }
        }

    
    }
}
    While ($b -eq 2) #This is the statement that in conjunction with the above variable, will ensure that the loop is continuous until a unique samAccountName is created 

$Export = @()
    $Export += New-Object psobject -Property @{Username = $User.samAccountName; Password = $pwd
     
    }

$Export | Export-Csv c:\usr\bin\ExportedResults.csv -NoTypeInformation -Append

}


