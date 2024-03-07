param location string = resourceGroup().location
param serviceBusName string
param tags object = {}
param serviceBusTopicName string
param serviceBusTopicAuthorizationRuleName string
param backendProcessorServiceName string

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: serviceBusName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
}

resource serviceBusTopic 'Microsoft.ServiceBus/namespaces/topics@2021-11-01' = {
  name: serviceBusTopicName
  parent: serviceBusNamespace
}

resource serviceBusTopicAuthRule 'Microsoft.ServiceBus/namespaces/topics/authorizationRules@2021-11-01' = {
  name: serviceBusTopicAuthorizationRuleName
  parent: serviceBusTopic
  properties: {
    rights: [
      'Manage'
      'Send'
      'Listen'
    ]
  }
}

resource serviceBusTopicSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-10-01-preview' = {
  name: backendProcessorServiceName
  parent: serviceBusTopic
}

output serviceBusName string = serviceBusNamespace.name
output serviceBusTopicName string = serviceBusTopic.name
output serviceBusTopicAuthorizationRuleName string = serviceBusTopicAuthRule.name
