metadata name = 'Azure Virtual Enclaves - Community'
metadata description = 'This module deploys a Microsoft Mission Community. THIS IS A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION.'

@description('Required. Name of the community.')
@minLength(2)
param name string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Enable/Disable usage telemetry for module.')
param enableTelemetry bool = true

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Address space of the community.')
param addressSpace string?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of address spaces of the community.')
param addressSpaces string[]?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Granular approval requirements for various actions on the community\'s resources.')
param approvalSettings approvalSettingsType?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community-scoped role assignments. Not to be confused with the `roleAssignments` parameter, which manages Azure RBAC role assignments on this resource.')
param communityRoleAssignments communityRoleAssignmentType[]?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. DNS servers used by the community.')
param dnsServers string[]?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. SKU of the community\'s Azure Firewall.')
@allowed([
  'Basic'
  'Premium'
  'Standard'
])
param firewallSku string = 'Standard'

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of services governed by the community.')
param governedServiceList governedServiceItemType[]?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Maintenance Mode configuration.')
param maintenanceModeConfiguration maintenanceModeConfigurationType?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community monitoring settings for diagnostic and virtual network flow logs.')
param monitoringSettings communityMonitoringSettingsType?

@description('Optional. THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Policy override setting for the community.')
@allowed([
  'Enclave'
  'None'
])
param policyOverride string?

import { managedIdentityAllType } from 'br/public:avm/utl/types/avm-common-types:0.7.0'
@description('Optional. The managed identity definition for this resource.')
param managedIdentities managedIdentityAllType?

import { lockType } from 'br/public:avm/utl/types/avm-common-types:0.7.0'
@description('Optional. The lock settings of the service.')
param lock lockType?

import { roleAssignmentType } from 'br/public:avm/utl/types/avm-common-types:0.7.0'
@description('Optional. Array of Azure RBAC role assignments to create on this resource. Not to be confused with `communityRoleAssignments`, which manages community-scoped access grants.')
param roleAssignments roleAssignmentType[]?

import { diagnosticSettingFullType } from 'br/public:avm/utl/types/avm-common-types:0.7.0'
@description('Optional. The diagnostic settings of the service.')
param diagnosticSettings diagnosticSettingFullType[]?

@description('Optional. Tags of the resource.')
param tags resourceInput<'Microsoft.Mission/communities@2026-03-01-preview'>.tags?

var formattedUserAssignedIdentities = reduce(
  map((managedIdentities.?userAssignedResourceIds ?? []), (id) => { '${id}': {} }),
  {},
  (cur, next) => union(cur, next)
) // Converts the flat array to an object like { '${id1}': {}, '${id2}': {} }

var identity = !empty(managedIdentities) || !empty(formattedUserAssignedIdentities)
  ? {
      type: (managedIdentities.?systemAssigned ?? false)
        ? (!empty(formattedUserAssignedIdentities) ? 'SystemAssigned,UserAssigned' : 'SystemAssigned')
        : (!empty(formattedUserAssignedIdentities) ? 'UserAssigned' : 'None')
      userAssignedIdentities: !empty(formattedUserAssignedIdentities) ? formattedUserAssignedIdentities : null
    }
  : null

var builtInRoleNames = {
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Role Based Access Control Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f58310d9-a9f6-439a-9e8d-f62e7b41a168'
  )
  'User Access Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
  )
}

var formattedRoleAssignments = [
  for (roleAssignment, index) in (roleAssignments ?? []): union(roleAssignment, {
    roleDefinitionId: builtInRoleNames[?roleAssignment.roleDefinitionIdOrName] ?? (contains(
        roleAssignment.roleDefinitionIdOrName,
        '/providers/Microsoft.Authorization/roleDefinitions/'
      )
      ? roleAssignment.roleDefinitionIdOrName
      : subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignment.roleDefinitionIdOrName))
  })
]

// ============== //
// Resources      //
// ============== //

#disable-next-line no-deployments-resources
resource avmTelemetry 'Microsoft.Resources/deployments@2025-04-01' = if (enableTelemetry) {
  name: '46d3xbcp.res.mission-community.${replace('-..--..-', '.', '-')}.${substring(uniqueString(deployment().name, location), 0, 4)}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
      outputs: {
        telemetry: {
          type: 'String'
          value: 'For more information, see https://aka.ms/avm/TelemetryInfo'
        }
      }
    }
  }
}

resource community 'Microsoft.Mission/communities@2026-03-01-preview' = {
  name: name
  location: location
  tags: tags
  identity: identity
  properties: {
    addressSpace: addressSpace
    addressSpaces: addressSpaces
    approvalSettings: approvalSettings
    communityRoleAssignments: communityRoleAssignments
    dnsServers: dnsServers
    firewallSku: firewallSku
    governedServiceList: governedServiceList
    maintenanceModeConfiguration: maintenanceModeConfiguration
    monitoringSettings: monitoringSettings
    policyOverride: policyOverride
  }
}

resource community_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock ?? {}) && lock.?kind != 'None') {
  name: lock.?name ?? 'lock-${name}'
  properties: {
    level: lock.?kind ?? ''
    notes: lock.?notes ?? (lock.?kind == 'CanNotDelete'
      ? 'Cannot delete resource or child resources.'
      : 'Cannot delete or modify the resource or child resources.')
  }
  scope: community
}

#disable-next-line use-recent-api-versions
resource community_diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [
  for (diagnosticSetting, index) in (diagnosticSettings ?? []): {
    name: diagnosticSetting.?name ?? '${name}-diagnosticSettings'
    properties: {
      storageAccountId: diagnosticSetting.?storageAccountResourceId
      workspaceId: diagnosticSetting.?workspaceResourceId
      eventHubAuthorizationRuleId: diagnosticSetting.?eventHubAuthorizationRuleResourceId
      eventHubName: diagnosticSetting.?eventHubName
      metrics: [
        for group in (diagnosticSetting.?metricCategories ?? (empty(diagnosticSetting.?logCategoriesAndGroups)
          ? [{ category: 'AllMetrics' }]
          : [])): {
          category: group.category
          enabled: group.?enabled ?? true
          timeGrain: null
        }
      ]
      logs: [
        for group in (diagnosticSetting.?logCategoriesAndGroups ?? (empty(diagnosticSetting.?metricCategories)
          ? [{ categoryGroup: 'allLogs' }]
          : [])): {
          categoryGroup: group.?categoryGroup
          category: group.?category
          enabled: group.?enabled ?? true
        }
      ]
      marketplacePartnerId: diagnosticSetting.?marketplacePartnerResourceId
      logAnalyticsDestinationType: diagnosticSetting.?logAnalyticsDestinationType
    }
    scope: community
  }
]

resource community_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for (roleAssignment, index) in (formattedRoleAssignments ?? []): {
    name: roleAssignment.?name ?? guid(community.id, roleAssignment.principalId, roleAssignment.roleDefinitionId)
    properties: {
      roleDefinitionId: roleAssignment.roleDefinitionId
      principalId: roleAssignment.principalId
      description: roleAssignment.?description
      principalType: roleAssignment.?principalType
      condition: roleAssignment.?condition
      conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
      delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
    }
    scope: community
  }
]

// ============ //
// Outputs      //
// ============ //

@description('The name of the community.')
output name string = community.name

@description('The resource ID of the community.')
output resourceId string = community.id

@description('The name of the resource group the community was created in.')
output resourceGroupName string = resourceGroup().name

@description('The principal ID of the system assigned identity.')
output systemAssignedMIPrincipalId string? = community.?identity.?principalId

@description('The location the resource was deployed into.')
output location string = community.location

// ================ //
// Definitions      //
// ================ //

@export()
@description('The type for a principal referenced by community role assignments and maintenance mode configuration.')
type principalType = {
  @description('Required. The object id associated with the principal.')
  id: string

  @description('Required. The type of the object id. Users, groups, and service principals are allowed.')
  type: ('Group' | 'ServicePrincipal' | 'User')
}

@export()
@description('The type for a mandatory approver.')
type mandatoryApproverType = {
  @description('Required. EntraId of the approver.')
  approverEntraId: string
}

@export()
@description('The type for an approval setting configuration.')
type approvalSettingConfigurationType = {
  @description('Optional. Approval policy (Required or NotRequired).')
  approvalPolicy: ('NotRequired' | 'Required')?

  @description('Optional. List of mandatory approvers for this approval setting.')
  mandatoryApprovers: mandatoryApproverType[]?

  @description('Optional. Minimum number of approvers required for this approval setting.')
  minimumApproversRequired: int?
}

@export()
@description('The type for granular approval requirements for various actions on the community\'s resources.')
type approvalSettingsType = {
  @description('Optional. Approval configuration for community endpoint updates.')
  communityEndpointUpdate: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for community maintenance mode.')
  communityMaintenanceMode: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for connection creation.')
  connectionCreation: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for connection updates.')
  connectionUpdate: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for enclave creation.')
  enclaveCreation: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for enclave endpoint updates.')
  enclaveEndpointUpdate: approvalSettingConfigurationType?

  @description('Optional. Approval configuration for enclave maintenance mode.')
  enclaveMaintenanceMode: approvalSettingConfigurationType?
}

@export()
@description('The type for a community-scoped role assignment.')
type communityRoleAssignmentType = {
  @description('Optional. Condition under which the principal can be granted permission.')
  condition: string?

  @description('Optional. List of principals to which to assign this role definition.')
  principals: principalType[]?

  @description('Required. Role definition identifier.')
  roleDefinitionId: string
}

@export()
@description('The type for a governed service item.')
type governedServiceItemType = {
  @description('Optional. Initiative enforcement (Enabled or Disabled).')
  enforcement: ('Disabled' | 'Enabled')?

  @description('Optional. Governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).')
  option: ('Allow' | 'Deny' | 'ExceptionOnly' | 'NotApplicable')?

  @description('Optional. Enforcement mode for policy.')
  policyAction: ('AuditOnly' | 'Enforce' | 'None')?

  @description('Required. Service ID.')
  serviceId: (
    | 'AKS'
    | 'AppService'
    | 'AzureFirewalls'
    | 'ContainerRegistry'
    | 'CosmosDB'
    | 'DataConnectors'
    | 'Insights'
    | 'KeyVault'
    | 'Logic'
    | 'MicrosoftSQL'
    | 'Monitoring'
    | 'PostgreSQL'
    | 'PrivateDNSZones'
    | 'ServiceBus'
    | 'Storage')
}

@export()
@description('The type for the maintenance mode configuration.')
type maintenanceModeConfigurationType = {
  @description('Optional. Justification for entering or exiting Maintenance Mode.')
  justification: ('Governance' | 'Networking' | 'Off')?

  @description('Required. Current mode of Maintenance Mode Configuration.')
  mode: ('Advanced' | 'CanNotDelete' | 'General' | 'Off' | 'On')

  @description('Optional. The user, group or service principal object affected by Maintenance Mode.')
  principals: principalType[]?
}

@export()
@description('The type for a community monitoring destination.')
type communityMonitoringDestinationType = {
  @description('Optional. Log Analytics workspace resource ID for a custom workspace.')
  customWorkspaceResourceId: string?

  @description('Required. The type of monitoring workspace destination.')
  destinationType: ('CommunityWorkspace' | 'CustomWorkspace' | 'EnclaveWorkspace')

  @description('Optional. Custom name for diagnostic settings.')
  diagnosticSettingsName: string?
}

@export()
@description('The type for the community monitoring settings.')
type communityMonitoringSettingsType = {
  @description('Optional. Log Analytics workspace destinations where diagnostic logs will be stored.')
  diagnosticDestinations: communityMonitoringDestinationType[]?

  @description('Optional. Log Analytics workspace destination where virtual network flow logs will be stored.')
  flowLogDestination: communityMonitoringDestinationType?
}
