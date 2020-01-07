# Defines a variable for a dotnet get started web app repository location
$gitrepo="https://github.com/Azure-Samples/app-service-web-dotnet-get-started.git"

# Unique web app name
$webappname="HF-FCV"

# Define Location
$location="UKSouth"

# Creates a resource group
$rg = New-AzResourceGroup -Name HF-FCV-RG -Location $location

# Create an App Service plan in Free tier.
New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName $rg.ResourceGroupName -Tier Standard

# Creates a web app
$webapp = New-AzWebApp -ResourceGroupName $rg.ResourceGroupName -Name $webappname -Location $location -AppServicePlan $webappname

# Configure GitHub deployment from your GitHub repo and deploy once to web app.
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $rg.ResourceGroupName -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force

# Creates a subnet for the application gateway
$subnet = New-AzVirtualNetworkSubnetConfig -Name HF-FCV-Subnet -AddressPrefix 10.0.2.0/24

# Creates a vnet for the application gateway
$vnet = New-AzVirtualNetwork -Name HF-FCV-vNet -ResourceGroupName $rg.ResourceGroupName -Location $location -AddressPrefix 10.0.2.0/24 -Subnet $subnet

# Retrieve the subnet object for use later
$subnet=$vnet.Subnets[0]

# Create a public IP address
$publicip = New-AzPublicIpAddress -ResourceGroupName $rg.ResourceGroupName -name HF-FCV-PublicIP -location $location -AllocationMethod Dynamic

# Create a new IP configuration
$gipconfig = New-AzApplicationGatewayIPConfiguration -Name HF-AppGW-01-IP -Subnet $subnet

# Create a backend pool with the hostname of the web app
$pool = New-AzApplicationGatewayBackendAddressPool -Name HF-AppGW-01-BackEndPool -BackendFqdns $webapp.HostNames

# Define the status codes to match for the probe
$match = New-AzApplicationGatewayProbeHealthResponseMatch -StatusCode 200-399

# Create a probe with the PickHostNameFromBackendHttpSettings switch for web apps
$probeconfig = New-AzApplicationGatewayProbeConfig -name HF-AppGW-01-Http-Probe -Protocol Http -Path / -Interval 30 -Timeout 120 -UnhealthyThreshold 3 -PickHostNameFromBackendHttpSettings -Match $match

# Define the backend http settings
$poolSetting = New-AzApplicationGatewayBackendHttpSettings -Name HF-AppGW-01-BackendHttpSettings -Port 80 -Protocol Http -CookieBasedAffinity Disabled -RequestTimeout 120 -PickHostNameFromBackendAddress -Probe $probeconfig

# Create a new front-end port
$fp = New-AzApplicationGatewayFrontendPort -Name HF-AppGW-01-FrontEndPort -Port 80

# Create a new front end IP configuration
$fipconfig = New-AzApplicationGatewayFrontendIPConfig -Name HF-AppGW-01-FrontendIPConfig -PublicIPAddress $publicip

# Create a new listener using the front-end ip configuration and port created earlier
$listener = New-AzApplicationGatewayHttpListener -Name HF-AppGW-01-ListenerHttp -Protocol Http -FrontendIPConfiguration $fipconfig -FrontendPort $fp

# Create a new rule
$rule = New-AzApplicationGatewayRequestRoutingRule -Name HF-AppGW-01-GatewayRoutingRule01 -RuleType Basic -BackendHttpSettings $poolSetting -HttpListener $listener -BackendAddressPool $pool

# Define the application gateway SKU to use
$sku = New-AzApplicationGatewaySku -Name WAF_Medium -Tier WAF -Capacity 2

# Create the application gateway
$appgw = New-AzApplicationGateway -Name HF-AppGW-01 -ResourceGroupName $rg.ResourceGroupName -Location $location -BackendAddressPools $pool -BackendHttpSettingsCollection $poolSetting -Probes $probeconfig -FrontendIpConfigurations $fipconfig  -GatewayIpConfigurations $gipconfig -FrontendPorts $fp -HttpListeners $listener -RequestRoutingRules $rule -Sku $sku