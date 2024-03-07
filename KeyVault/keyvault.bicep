param location string = resourceGroup().location
param KEYVAULT_NAME string
param tags object = {}

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: KEYVAULT_NAME
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableSoftDelete: false
    softDeleteRetentionInDays: 7
    enablePurgeProtection: null
    enableRbacAuthorization: true
    enabledForTemplateDeployment: true
  }
}

output keyVaultId string = keyVault.id
