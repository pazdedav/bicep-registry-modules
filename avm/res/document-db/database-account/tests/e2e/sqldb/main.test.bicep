targetScope = 'subscription'

metadata name = 'SQL Database'
metadata description = 'This instance deploys the module with a SQL Database.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-documentdb.databaseaccounts-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'dddasql'

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceLocation
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
    virtualNetworkName: 'dep-${namePrefix}-vnet-${serviceShort}'
    pairedRegionScriptName: 'dep-${namePrefix}-ds-${serviceShort}'
    location: resourceLocation
  }
}

// Diagnostics
// ===========
module diagnosticDependencies '../../../../../../utilities/e2e-template-assets/templates/diagnostic.dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-diagnosticDependencies'
  params: {
    storageAccountName: 'dep${namePrefix}diasa${serviceShort}01'
    logAnalyticsWorkspaceName: 'dep-${namePrefix}-law-${serviceShort}'
    eventHubNamespaceEventHubName: 'dep-${namePrefix}-evh-${serviceShort}'
    eventHubNamespaceName: 'dep-${namePrefix}-evhns-${serviceShort}'
    location: resourceLocation
  }
}

// ============== //
// Test Execution //
// ============== //

module testDeployment '../../../main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}'
  params: {
    name: '${namePrefix}${serviceShort}001'
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: resourceLocation
      }
      {
        failoverPriority: 1
        isZoneRedundant: false
        locationName: nestedDependencies.outputs.pairedRegionName
      }
    ]
    diagnosticSettings: [
      {
        name: 'customSetting'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        eventHubName: diagnosticDependencies.outputs.eventHubNamespaceEventHubName
        eventHubAuthorizationRuleResourceId: diagnosticDependencies.outputs.eventHubAuthorizationRuleId
        storageAccountResourceId: diagnosticDependencies.outputs.storageAccountResourceId
        workspaceResourceId: diagnosticDependencies.outputs.logAnalyticsWorkspaceResourceId
      }
    ]
    location: resourceLocation
    privateEndpoints: [
      {
        privateDnsZoneResourceIds: [
          nestedDependencies.outputs.privateDNSZoneResourceId
        ]
        service: 'Sql'
        subnetResourceId: nestedDependencies.outputs.subnetResourceId
        tags: {
          'hidden-title': 'This is visible in the resource name'
          Environment: 'Non-Prod'
          Role: 'DeploymentValidation'
        }
      }
    ]
    roleAssignments: [
      {
        roleDefinitionIdOrName: 'Owner'
        principalId: nestedDependencies.outputs.managedIdentityPrincipalId
        principalType: 'ServicePrincipal'
      }
      {
        roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
        principalId: nestedDependencies.outputs.managedIdentityPrincipalId
        principalType: 'ServicePrincipal'
      }
      {
        roleDefinitionIdOrName: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
        principalId: nestedDependencies.outputs.managedIdentityPrincipalId
        principalType: 'ServicePrincipal'
      }
    ]
    sqlDatabases: [
      {
        containers: [
          {
            kind: 'Hash'
            name: 'container-001'
            indexingPolicy: {
              automatic: true
            }
            paths: [
              '/myPartitionKey'
            ]
            analyticalStorageTtl: 0
            conflictResolutionPolicy: {
              conflictResolutionPath: '/myCustomId'
              mode: 'LastWriterWins'
            }
            defaultTtl: 1000
            uniqueKeyPolicyKeys: [
              {
                paths: [
                  '/firstName'
                ]
              }
              {
                paths: [
                  '/lastName'
                ]
              }
            ]
            throughput: 600
          }
        ]
        name: '${namePrefix}-sql-${serviceShort}-001'
      }
      {
        containers: []
        name: '${namePrefix}-sql-${serviceShort}-002'
      }
      {
        containers: [
          {
            kind: 'Hash'
            name: 'container-003'
            autoscaleSettingsMaxThroughput: 1000
            indexingPolicy: {
              automatic: true
            }
            paths: [
              '/myPartitionKey'
            ]
            analyticalStorageTtl: 0
            conflictResolutionPolicy: {
              conflictResolutionPath: '/myCustomId'
              mode: 'LastWriterWins'
            }
            uniqueKeyPolicyKeys: [
              {
                paths: [
                  '/firstName'
                ]
              }
              {
                paths: [
                  '/lastName'
                ]
              }
            ]
          }
        ]
        name: '${namePrefix}-sql-${serviceShort}-003'
        autoscaleSettingsMaxThroughput: 1000
      }
    ]
    managedIdentities: {
      userAssignedResourceIds: [
        nestedDependencies.outputs.managedIdentityResourceId
      ]
    }
    tags: {
      'hidden-title': 'This is visible in the resource name'
      Environment: 'Non-Prod'
      Role: 'DeploymentValidation'
    }
  }
}
