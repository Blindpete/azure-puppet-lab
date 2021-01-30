param location string = resourceGroup().location
param virtualNetworkName string = 'lab-vnet'
param subnetName string = 'lab-subnet'

resource virtualNetworkName_resource 'Microsoft.Network/VirtualNetworks@2019-09-01' = {
  name: virtualNetworkName
  location: location
  tags: {}
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
  dependsOn: []
}

output vnetid string = virtualNetworkName_resource.id