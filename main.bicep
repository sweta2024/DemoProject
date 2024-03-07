param appServicePlanName string
param location string = resourceGroup().location
param storageAccountName string
param logicAppName string
param serviceBusName string
param apiConnName string
param displayName string
param serviceBusTopicName string
param serviceBusTopicAuthorizationRuleName string
param backendProcessorServiceName string
param logAnalyticsWorkspaceName string
param applicationInsightName string
param keyVaultName string

module logicApp 'LogicApp/LogicApp.bicep' = {
  name: logicAppName
  dependsOn: [
    appServicePlan, storageaccount
  ]
  params: {
    logicAppName: logicAppName
    location: location
    AppServicePlanId: appServicePlan.outputs.aspId
    storageAccountId: storageaccount.outputs.StorageAccountResourceId
    storageAccountName: storageaccount.outputs.StorageAccountResourceName
    Key:applicationInsights.outputs.appInsight_Inst_Key
    Connectionstring:applicationInsights.outputs.appInsight_Conn_Str
  }
}

module storageaccount 'StorageAccount/StorageAccount.bicep' = {
  name: storageAccountName
  dependsOn: [
    appServicePlan
  ]
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

module appServicePlan 'AppServicePlan/ServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    appServicePlanName: appServicePlanName
    location: location
  }
}

module apiConnection 'ApiConnection/Office365Conn.bicep' = {
  name: apiConnName
  params: {
    location: location
    apiConnName: apiConnName
    displayName: displayName
  }
}

module serviceBus 'ServiceBus/ServiceBus.bicep' = {
  name: serviceBusName
  params: {
    serviceBusName: serviceBusName
    location: location
    tags: {}
    serviceBusTopicName: serviceBusTopicName
    serviceBusTopicAuthorizationRuleName: serviceBusTopicAuthorizationRuleName
    backendProcessorServiceName: backendProcessorServiceName
  }
}

module applicationInsights 'ApplicationInsights/AppIn.bicep' = {
  name: applicationInsightName
  params: {
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    applicationInsightName: applicationInsightName
    location: location
  }
}

module keyVault 'KeyVault/keyvault.bicep' = {
  name: keyVaultName
  params: {
    KEYVAULT_NAME: keyVaultName
    location: location
  }
}
