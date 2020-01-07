#Add needed Assemblies

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")

function Gather-Input
{
    $objForm = New-Object System.Windows.Forms.Form 
    $objForm.Text = "New Build Installation"
    $objForm.Size = New-Object System.Drawing.Size(500,300) 
    $objForm.StartPosition = "CenterScreen"
    $objForm.KeyPreview = $True
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(10,220)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $objForm.AcceptButton = $OKButton
    $objForm.Controls.Add($OKButton)
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(90,220)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $objForm.CancelButton = $CancelButton
    $objForm.Controls.Add($CancelButton)
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,20) 
    $objLabel.Size = New-Object System.Drawing.Size(400,20) 
    $objLabel.Text = "What would you like the user account renamed to:"
    $objForm.Controls.Add($objLabel) 
    $objTextBox = New-Object System.Windows.Forms.TextBox 
    $objTextBox.Location = New-Object System.Drawing.Size(10,40) 
    $objTextBox.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox) 
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,70) 
    $objLabel.Size = New-Object System.Drawing.Size(400,20) 
    $objLabel.Text = "What is the #:"
    $objForm.Controls.Add($objLabel) 
    
    $objTextBox2 = New-Object System.Windows.Forms.TextBox 
    $objTextBox2.Location = New-Object System.Drawing.Size(10,90) 
    $objTextBox2.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox2) 
    
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,120) 
    $objLabel.Size = New-Object System.Drawing.Size(400,20) 
    $objLabel.Text = "Enter a username that can be used to join the domain:"
    $objForm.Controls.Add($objLabel) 
    
    $objTextBox3 = New-Object System.Windows.Forms.TextBox 
    $objTextBox3.Location = New-Object System.Drawing.Size(10,140) 
    $objTextBox3.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox3) 
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,170) 
    $objLabel.Size = New-Object System.Drawing.Size(400,20) 
    $objLabel.Text = "Enter the password for the above account:"
    $objForm.Controls.Add($objLabel) 
    $objTextBox4 = New-Object System.Windows.Forms.MaskedTextBox
    $objTextBox4.PasswordChar = '*'
    $objTextBox4.Location = New-Object System.Drawing.Size(10,190) 
    $objTextBox4.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox4) 
    
    $objForm.Topmost = $True
    $objForm.Add_Shown({$objForm.Activate()})
    
    $dialogResult = $objForm.ShowDialog()

    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK)
    {
        New-Object psobject -Property @{
            NewUser    = $objTextBox.Text
            Number     = $objTextBox2.Text
            DomainUser = $objTextBox3.Text
            DomainPass = $objTextBox4.Text
        }
    }
    else
    {
        throw 'Operation cancelled by user.'
    }
}

function Rename-UserAccount
{
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]
        $NewUser
    )

    process
    {
        $User = [ADSI]("WinNT://$Env:COMPUTERNAME/mobileuser,User")
        $User.psbase.rename($NewUser)
        $delUser = "setup"
        $computer = [adsi]("WinNT://$env:COMPUTERNAME")
        $computer.psbase.invoke("Delete","User",$delUser)
    }
}

$userInput = Gather-Input