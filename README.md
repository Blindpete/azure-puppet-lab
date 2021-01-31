# azure-puppet-lab
Lab for learning puppet.

## Prerequisites 

- Powershell AZ Mdoules Installed
- Bicep Instaled https://github.com/Azure/bicep/releases
- SSH Key in ~/.ssh/ (ssh-keygen -m PEM -t rsa -b 4096)

## build + deploy
```powershell
$rg = 'uks-puppet-lab-rg'
$TemplateParameterObject = @{
    accessIP = (curl ifconfig.me/ip -s)
    adminPassword = (Invoke-RestMethod -Uri 'https://passwordwolf.com:443/api/?length=32&repeat=1').password
    adminPublicKey = (cat $env:USERPROFILE\.ssh\id_rsa.pub)
}

bicep.exe build .\main.bicep

$splat = @{
    name = 'puppet-lab'
    TemplateParameterObject = $TemplateParameterObject 
    TemplateFile = './main.json' 
    ResourceGroupName =  'uks-puppet-lab-rg' 
}
New-AzResourceGroupDeployment @splat
```