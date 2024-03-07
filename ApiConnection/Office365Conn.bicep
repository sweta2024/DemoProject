param location string = resourceGroup().location
param apiConnName string
param displayName string
 
resource office365_conn 'Microsoft.Web/connections@2016-06-01' = {
  name: apiConnName
  location: location
  kind: 'V2'
  tags: {}
  properties: {
    api: {
      name: apiConnName
      displayName: 'Office 365 Outlook'
      description: 'Microsoft Office 365 is a cloud-based service that is designed to help meet your organization\'s needs for robust security, reliability, and user productivity.'
      id: 'subscriptions/${subscription().subscriptionId}/providers/Microsoft.Web/locations/${location}/managedApis/office365'
      iconUri: 'https://connectoricons-prod.azureedge.net/releases/v1.0.1588/1.0.1588.2938/office365/icon.png'
      brandColor: '#0078D4'
      type: 'Microsoft.Web/locations/managedApis'
    }
    displayName: displayName
    statuses: [
      {
        status: 'Connected'
      }
    ]
  }
}
