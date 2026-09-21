targetScope = 'subscription'

metadata name = 'Using large parameter set'
metadata description = 'This instance deploys the module with most of its parameters set.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-mission.communities-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'mcmax'

@description('Optional. A token to inject into the name of each resource. This value can be automatically injected by the CI.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: resourceLocation
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
  }
}

// ============== //
// Test Execution //
// ============== //

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}001'
      location: resourceLocation
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
      lock: {
        kind: 'CanNotDelete'
        name: 'lock'
      }
      managedIdentities: {
        systemAssigned: true
        userAssignedResourceIds: [
          nestedDependencies.outputs.managedIdentityResourceId
        ]
      }
      roleAssignments: [
        {
          roleDefinitionIdOrName: 'Reader'
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          roleDefinitionIdOrName: subscriptionResourceId(
            'Microsoft.Authorization/roleDefinitions',
            'b24988ac-6180-42a0-ab88-20f7382dd24c'
          )
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
      ]
      addressSpace: '10.0.0.0/16'
      addressSpaces: [
        '10.0.0.0/16'
      ]
      dnsServers: [
        '10.0.0.4'
        '10.0.0.5'
      ]
      firewallSku: 'Premium'
      policyOverride: 'None'
      communityRoleAssignments: [
        {
          roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
          principals: [
            {
              id: nestedDependencies.outputs.managedIdentityPrincipalId
              type: 'ServicePrincipal'
            }
          ]
        }
      ]
      governedServiceList: [
        {
          serviceId: 'Storage'
          option: 'Allow'
          enforcement: 'Enabled'
          policyAction: 'Enforce'
        }
        {
          serviceId: 'KeyVault'
          option: 'Deny'
          enforcement: 'Enabled'
          policyAction: 'AuditOnly'
        }
      ]
      maintenanceModeConfiguration: {
        mode: 'Off'
        justification: 'Off'
      }
      approvalSettings: {
        connectionCreation: {
          approvalPolicy: 'Required'
          minimumApproversRequired: 1
          mandatoryApprovers: [
            {
              approverEntraId: nestedDependencies.outputs.managedIdentityPrincipalId
            }
          ]
        }
        enclaveCreation: {
          approvalPolicy: 'NotRequired'
        }
      }
    }
  }
]
