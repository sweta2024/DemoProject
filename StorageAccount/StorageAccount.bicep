param storageAccountName string
param location string = resourceGroup().location
resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: {}
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}

output StorageAccountResourceId string = storageaccount.id
output StorageAccountResourceName string = storageaccount.name
