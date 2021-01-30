param name string = 'lab.test'
param virtualNetworkId string

resource name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: name
  location: 'global'
  tags: {}
  properties: {}
  dependsOn: []
}

resource lab_test_priv_dns_lab_vnet_link 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  name: '${name_resource.name}/priv-dns-lab-vnet-link'
  location: 'global'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}