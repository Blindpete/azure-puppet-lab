param accessIP string
param adminPassword string {
  secure: true
}
param adminPublicKey string 


module vnet './VirtualNetwork/main.bicep' = {
  name: 'lab-vnet'
  params: {
    virtualNetworkName: 'lab-vnet'
    subnetName: 'lab-subnet'
  }
}

module privdns './PrivateDnsZone/main.bicep' = {
  name: 'Priv-lab-test'
  params: {
    virtualNetworkId: '${vnet.outputs.vnetid}'
  }  
}

module vm0 './CentOS-7_9/main.bicep' = {
  name: 'vm-lin1'
  params: {
    virtualMachineName: 'lin1'
    virtualMachineSize: 'Standard_D2s_v3'
    subnetName: 'lab-subnet'
    virtualNetworkId:  '${vnet.outputs.vnetid}'
    adminPublicKey: adminPublicKey
    sourceAddressPrefix: accessIP
  }
}

module vm1 './CentOS-7_9/main.bicep' = {
  name: 'vm-puppet'
  params: {
    virtualMachineName: 'puppet'
    virtualMachineSize: 'Standard_D2s_v3'
    subnetName: 'lab-subnet'
    virtualNetworkId:  '${vnet.outputs.vnetid}'
    adminPublicKey: adminPublicKey
    sourceAddressPrefix: accessIP
  }
}

module installpuppetserver './CustomScript-extensions/main.bicep' = {
  name: 'install-puppet-server'
  params:{
    configName: 'install-puppet-server'
    vmName: 'puppet'
    fileUris: 'https://raw.githubusercontent.com/Blindpete/azure-puppet-lab/main/scripts/install-puppet-server.sh'
    commandToExecute: 'sh install-puppet-server.sh'
  }
}

module vm2 './WindowsServer-2019/main.bicep' = {
  name: 'vm-win1'
  params: {
    virtualMachineName: 'win1'
    virtualMachineSize: 'Standard_D2s_v3'
    adminPassword: adminPassword
    subnetName: 'lab-subnet'
    virtualNetworkId:  '${vnet.outputs.vnetid}'
    sourceAddressPrefix: accessIP
  }
  
}