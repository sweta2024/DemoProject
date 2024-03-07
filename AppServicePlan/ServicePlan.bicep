param appServicePlanName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: {}
  sku: {
    name: 'WS1'
  }
  kind: 'Windows'
}

output aspId string = appServicePlan.id
