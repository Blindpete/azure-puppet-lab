param vmName string
param location string {
  metadata: {
    description: 'Location for all resources.'
  }
  default: resourceGroup().location
}
param fileUris string
param commandToExecute string
param configName string

resource vmName_configuremongo 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  name: '${vmName}/${configName}'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.0'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        fileUris
      ]
      commandToExecute: commandToExecute
    }
  }
}