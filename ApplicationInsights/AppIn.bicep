param location string = resourceGroup().location
param tags object = {}
param logAnalyticsWorkspaceName string
param applicationInsightName string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  tags: tags
  properties: any({
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  })
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

output applicationInsightsName string = applicationInsights.name
output appInsight_Inst_Key string = applicationInsights.properties.InstrumentationKey
output appInsight_Conn_Str string = applicationInsights.properties.ConnectionString
