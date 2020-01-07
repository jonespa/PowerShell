$package = "C:\ProgramData\TITUS\TITUS2.new.tcpg",
$config = "POC48ps1_Apr_13_18",
$file = "c:\test\test.doc"
$dllpath = "C:\Program Files\TITUS"

[System.Reflection.Assembly]::LoadFrom("$dllpath\AutoMapper.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\HtmlAgilityPack.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\log4net.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Practices.EnterpriseLibrary.Common.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Practices.ServiceLocation.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Practices.Unity.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Practices.Unity.Interception.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Synchronization.Data.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Synchronization.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Microsoft.Win32.TaskScheduler.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Newtonsoft.Json.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Rhino.Licensing.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Admin.Resources.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Bus.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Bus.Messages.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Common.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Domain.Client.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Domain.Common.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Domain.Types.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Metadata.SDK.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.PackageManager.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Plugin.Interface.dll") > $nullS
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Runtime.Resources.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Wcf.FaultContracts.dll") > $null
[System.Reflection.Assembly]::LoadFrom("$dllpath\Titus.Wcf.ServiceContracts.dll") > $null

$instance = New-Object Titus.Metadata.SDK.MetadataAPI $package, $config
$result = $instance.ReadAllMetadataProperties($file);
Write-Output $result 
