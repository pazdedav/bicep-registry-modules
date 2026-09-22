# Azure Virtual Enclaves - Community `[Microsoft.Mission/communities]`

This module deploys a Microsoft Mission Community. THIS IS A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION.

You can reference the module as follows:
```bicep
module community 'br/public:avm/res/mission/community:<version>' = {
  params: { (...) }
}
```
For examples, please refer to the [Usage Examples](#usage-examples) section.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version | References |
| :-- | :-- | :-- |
| `Microsoft.Authorization/locks` | 2020-05-01 | <ul style="padding-left: 0px;"><li>[AzAdvertizer](https://www.azadvertizer.net/azresourcetypes/microsoft.authorization_locks.html)</li><li>[Template reference](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks)</li></ul> |
| `Microsoft.Authorization/roleAssignments` | 2022-04-01 | <ul style="padding-left: 0px;"><li>[AzAdvertizer](https://www.azadvertizer.net/azresourcetypes/microsoft.authorization_roleassignments.html)</li><li>[Template reference](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments)</li></ul> |
| `Microsoft.Insights/diagnosticSettings` | 2021-05-01-preview | <ul style="padding-left: 0px;"><li>[AzAdvertizer](https://www.azadvertizer.net/azresourcetypes/microsoft.insights_diagnosticsettings.html)</li><li>[Template reference](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2021-05-01-preview/diagnosticSettings)</li></ul> |
| `Microsoft.Mission/communities` | 2026-03-01-preview | <ul style="padding-left: 0px;"><li>[AzAdvertizer](https://www.azadvertizer.net/azresourcetypes/microsoft.mission_communities.html)</li><li>[Template reference](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Mission/2026-03-01-preview/communities)</li></ul> |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/mission/community:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.

You can find the full example and the setup of its dependencies in the deployment test folder path [/tests/e2e/defaults]


<details>

<summary>via Bicep module</summary>

```bicep
module community 'br/public:avm/res/mission/community:<version>' = {
  params: {
    // Required parameters
    name: 'mcmin001'
    // Non-required parameters
    addressSpace: '10.0.0.0/16'
    location: '<location>'
    policyOverride: 'None'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "mcmin001"
    },
    // Non-required parameters
    "addressSpace": {
      "value": "10.0.0.0/16"
    },
    "location": {
      "value": "<location>"
    },
    "policyOverride": {
      "value": "None"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/mission/community:<version>'

// Required parameters
param name = 'mcmin001'
// Non-required parameters
param addressSpace = '10.0.0.0/16'
param location = '<location>'
param policyOverride = 'None'
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its parameters set.

You can find the full example and the setup of its dependencies in the deployment test folder path [/tests/e2e/max]


<details>

<summary>via Bicep module</summary>

```bicep
module community 'br/public:avm/res/mission/community:<version>' = {
  params: {
    // Required parameters
    name: 'mcmax001'
    // Non-required parameters
    addressSpace: '10.0.0.0/16'
    addressSpaces: [
      '10.0.0.0/16'
    ]
    approvalSettings: {
      connectionCreation: {
        approvalPolicy: 'Required'
        mandatoryApprovers: [
          {
            approverEntraId: '<approverEntraId>'
          }
        ]
        minimumApproversRequired: 1
      }
      enclaveCreation: {
        approvalPolicy: 'NotRequired'
      }
    }
    communityRoleAssignments: [
      {
        principals: [
          {
            id: '<id>'
            type: 'ServicePrincipal'
          }
        ]
        roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
    ]
    dnsServers: [
      '10.0.0.4'
      '10.0.0.5'
    ]
    firewallSku: 'Premium'
    governedServiceList: [
      {
        enforcement: 'Enabled'
        option: 'Allow'
        policyAction: 'Enforce'
        serviceId: 'Storage'
      }
      {
        enforcement: 'Enabled'
        option: 'Deny'
        policyAction: 'AuditOnly'
        serviceId: 'KeyVault'
      }
    ]
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'lock'
    }
    maintenanceModeConfiguration: {
      justification: 'Off'
      mode: 'Off'
    }
    policyOverride: 'None'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "mcmax001"
    },
    // Non-required parameters
    "addressSpace": {
      "value": "10.0.0.0/16"
    },
    "addressSpaces": {
      "value": [
        "10.0.0.0/16"
      ]
    },
    "approvalSettings": {
      "value": {
        "connectionCreation": {
          "approvalPolicy": "Required",
          "mandatoryApprovers": [
            {
              "approverEntraId": "<approverEntraId>"
            }
          ],
          "minimumApproversRequired": 1
        },
        "enclaveCreation": {
          "approvalPolicy": "NotRequired"
        }
      }
    },
    "communityRoleAssignments": {
      "value": [
        {
          "principals": [
            {
              "id": "<id>",
              "type": "ServicePrincipal"
            }
          ],
          "roleDefinitionId": "b24988ac-6180-42a0-ab88-20f7382dd24c"
        }
      ]
    },
    "dnsServers": {
      "value": [
        "10.0.0.4",
        "10.0.0.5"
      ]
    },
    "firewallSku": {
      "value": "Premium"
    },
    "governedServiceList": {
      "value": [
        {
          "enforcement": "Enabled",
          "option": "Allow",
          "policyAction": "Enforce",
          "serviceId": "Storage"
        },
        {
          "enforcement": "Enabled",
          "option": "Deny",
          "policyAction": "AuditOnly",
          "serviceId": "KeyVault"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "lock"
      }
    },
    "maintenanceModeConfiguration": {
      "value": {
        "justification": "Off",
        "mode": "Off"
      }
    },
    "policyOverride": {
      "value": "None"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        },
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "<roleDefinitionIdOrName>"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/mission/community:<version>'

// Required parameters
param name = 'mcmax001'
// Non-required parameters
param addressSpace = '10.0.0.0/16'
param addressSpaces = [
  '10.0.0.0/16'
]
param approvalSettings = {
  connectionCreation: {
    approvalPolicy: 'Required'
    mandatoryApprovers: [
      {
        approverEntraId: '<approverEntraId>'
      }
    ]
    minimumApproversRequired: 1
  }
  enclaveCreation: {
    approvalPolicy: 'NotRequired'
  }
}
param communityRoleAssignments = [
  {
    principals: [
      {
        id: '<id>'
        type: 'ServicePrincipal'
      }
    ]
    roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  }
]
param dnsServers = [
  '10.0.0.4'
  '10.0.0.5'
]
param firewallSku = 'Premium'
param governedServiceList = [
  {
    enforcement: 'Enabled'
    option: 'Allow'
    policyAction: 'Enforce'
    serviceId: 'Storage'
  }
  {
    enforcement: 'Enabled'
    option: 'Deny'
    policyAction: 'AuditOnly'
    serviceId: 'KeyVault'
  }
]
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'lock'
}
param maintenanceModeConfiguration = {
  justification: 'Off'
  mode: 'Off'
}
param policyOverride = 'None'
param roleAssignments = [
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'Reader'
  }
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
  }
]
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
```

</details>
<p>

### Example 3: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.

You can find the full example and the setup of its dependencies in the deployment test folder path [/tests/e2e/waf-aligned]


<details>

<summary>via Bicep module</summary>

```bicep
module community 'br/public:avm/res/mission/community:<version>' = {
  params: {
    // Required parameters
    name: 'mcwaf001'
    // Non-required parameters
    addressSpace: '10.0.0.0/16'
    diagnosticSettings: [
      {
        eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
        eventHubName: '<eventHubName>'
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        storageAccountResourceId: '<storageAccountResourceId>'
        workspaceResourceId: '<workspaceResourceId>'
      }
    ]
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'lock'
    }
    monitoringSettings: {
      diagnosticDestinations: [
        {
          customWorkspaceResourceId: '<customWorkspaceResourceId>'
          destinationType: 'CustomWorkspace'
        }
      ]
    }
    policyOverride: 'None'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "mcwaf001"
    },
    // Non-required parameters
    "addressSpace": {
      "value": "10.0.0.0/16"
    },
    "diagnosticSettings": {
      "value": [
        {
          "eventHubAuthorizationRuleResourceId": "<eventHubAuthorizationRuleResourceId>",
          "eventHubName": "<eventHubName>",
          "metricCategories": [
            {
              "category": "AllMetrics"
            }
          ],
          "name": "customSetting",
          "storageAccountResourceId": "<storageAccountResourceId>",
          "workspaceResourceId": "<workspaceResourceId>"
        }
      ]
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "lock"
      }
    },
    "monitoringSettings": {
      "value": {
        "diagnosticDestinations": [
          {
            "customWorkspaceResourceId": "<customWorkspaceResourceId>",
            "destinationType": "CustomWorkspace"
          }
        ]
      }
    },
    "policyOverride": {
      "value": "None"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/mission/community:<version>'

// Required parameters
param name = 'mcwaf001'
// Non-required parameters
param addressSpace = '10.0.0.0/16'
param diagnosticSettings = [
  {
    eventHubAuthorizationRuleResourceId: '<eventHubAuthorizationRuleResourceId>'
    eventHubName: '<eventHubName>'
    metricCategories: [
      {
        category: 'AllMetrics'
      }
    ]
    name: 'customSetting'
    storageAccountResourceId: '<storageAccountResourceId>'
    workspaceResourceId: '<workspaceResourceId>'
  }
]
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'lock'
}
param monitoringSettings = {
  diagnosticDestinations: [
    {
      customWorkspaceResourceId: '<customWorkspaceResourceId>'
      destinationType: 'CustomWorkspace'
    }
  ]
}
param policyOverride = 'None'
param roleAssignments = [
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'Reader'
  }
]
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | Name of the community. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`addressSpace`](#parameter-addressspace) | string | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Address space of the community. |
| [`addressSpaces`](#parameter-addressspaces) | array | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of address spaces of the community. |
| [`approvalSettings`](#parameter-approvalsettings) | object | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Granular approval requirements for various actions on the community's resources. |
| [`communityRoleAssignments`](#parameter-communityroleassignments) | array | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community-scoped role assignments. Not to be confused with the `roleAssignments` parameter, which manages Azure RBAC role assignments on this resource. |
| [`diagnosticSettings`](#parameter-diagnosticsettings) | array | The diagnostic settings of the service. |
| [`dnsServers`](#parameter-dnsservers) | array | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. DNS servers used by the community. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`firewallSku`](#parameter-firewallsku) | string | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. SKU of the community's Azure Firewall. |
| [`governedServiceList`](#parameter-governedservicelist) | array | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of services governed by the community. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`maintenanceModeConfiguration`](#parameter-maintenancemodeconfiguration) | object | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Maintenance Mode configuration. |
| [`managedIdentities`](#parameter-managedidentities) | object | The managed identity definition for this resource. |
| [`monitoringSettings`](#parameter-monitoringsettings) | object | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community monitoring settings for diagnostic and virtual network flow logs. |
| [`policyOverride`](#parameter-policyoverride) | string | THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Policy override setting for the community. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of Azure RBAC role assignments to create on this resource. Not to be confused with `communityRoleAssignments`, which manages community-scoped access grants. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |

### Parameter: `name`

Name of the community.

- Required: Yes
- Type: string

### Parameter: `addressSpace`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Address space of the community.

- Required: No
- Type: string

### Parameter: `addressSpaces`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of address spaces of the community.

- Required: No
- Type: array

### Parameter: `approvalSettings`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Granular approval requirements for various actions on the community's resources.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`communityEndpointUpdate`](#parameter-approvalsettingscommunityendpointupdate) | object | Approval configuration for community endpoint updates. |
| [`communityMaintenanceMode`](#parameter-approvalsettingscommunitymaintenancemode) | object | Approval configuration for community maintenance mode. |
| [`connectionCreation`](#parameter-approvalsettingsconnectioncreation) | object | Approval configuration for connection creation. |
| [`connectionUpdate`](#parameter-approvalsettingsconnectionupdate) | object | Approval configuration for connection updates. |
| [`enclaveCreation`](#parameter-approvalsettingsenclavecreation) | object | Approval configuration for enclave creation. |
| [`enclaveEndpointUpdate`](#parameter-approvalsettingsenclaveendpointupdate) | object | Approval configuration for enclave endpoint updates. |
| [`enclaveMaintenanceMode`](#parameter-approvalsettingsenclavemaintenancemode) | object | Approval configuration for enclave maintenance mode. |

### Parameter: `approvalSettings.communityEndpointUpdate`

Approval configuration for community endpoint updates.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingscommunityendpointupdateapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingscommunityendpointupdatemandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingscommunityendpointupdateminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.communityEndpointUpdate.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.communityEndpointUpdate.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingscommunityendpointupdatemandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.communityEndpointUpdate.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.communityEndpointUpdate.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.communityMaintenanceMode`

Approval configuration for community maintenance mode.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingscommunitymaintenancemodeapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingscommunitymaintenancemodemandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingscommunitymaintenancemodeminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.communityMaintenanceMode.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.communityMaintenanceMode.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingscommunitymaintenancemodemandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.communityMaintenanceMode.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.communityMaintenanceMode.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.connectionCreation`

Approval configuration for connection creation.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingsconnectioncreationapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingsconnectioncreationmandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingsconnectioncreationminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.connectionCreation.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.connectionCreation.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingsconnectioncreationmandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.connectionCreation.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.connectionCreation.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.connectionUpdate`

Approval configuration for connection updates.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingsconnectionupdateapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingsconnectionupdatemandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingsconnectionupdateminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.connectionUpdate.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.connectionUpdate.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingsconnectionupdatemandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.connectionUpdate.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.connectionUpdate.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.enclaveCreation`

Approval configuration for enclave creation.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingsenclavecreationapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingsenclavecreationmandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingsenclavecreationminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.enclaveCreation.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.enclaveCreation.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingsenclavecreationmandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.enclaveCreation.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.enclaveCreation.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.enclaveEndpointUpdate`

Approval configuration for enclave endpoint updates.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingsenclaveendpointupdateapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingsenclaveendpointupdatemandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingsenclaveendpointupdateminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.enclaveEndpointUpdate.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.enclaveEndpointUpdate.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingsenclaveendpointupdatemandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.enclaveEndpointUpdate.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.enclaveEndpointUpdate.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `approvalSettings.enclaveMaintenanceMode`

Approval configuration for enclave maintenance mode.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approvalPolicy`](#parameter-approvalsettingsenclavemaintenancemodeapprovalpolicy) | string | Approval policy (Required or NotRequired). |
| [`mandatoryApprovers`](#parameter-approvalsettingsenclavemaintenancemodemandatoryapprovers) | array | List of mandatory approvers for this approval setting. |
| [`minimumApproversRequired`](#parameter-approvalsettingsenclavemaintenancemodeminimumapproversrequired) | int | Minimum number of approvers required for this approval setting. |

### Parameter: `approvalSettings.enclaveMaintenanceMode.approvalPolicy`

Approval policy (Required or NotRequired).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'NotRequired'
    'Required'
  ]
  ```

### Parameter: `approvalSettings.enclaveMaintenanceMode.mandatoryApprovers`

List of mandatory approvers for this approval setting.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`approverEntraId`](#parameter-approvalsettingsenclavemaintenancemodemandatoryapproversapproverentraid) | string | EntraId of the approver. |

### Parameter: `approvalSettings.enclaveMaintenanceMode.mandatoryApprovers.approverEntraId`

EntraId of the approver.

- Required: Yes
- Type: string

### Parameter: `approvalSettings.enclaveMaintenanceMode.minimumApproversRequired`

Minimum number of approvers required for this approval setting.

- Required: No
- Type: int

### Parameter: `communityRoleAssignments`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community-scoped role assignments. Not to be confused with the `roleAssignments` parameter, which manages Azure RBAC role assignments on this resource.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`roleDefinitionId`](#parameter-communityroleassignmentsroledefinitionid) | string | Role definition identifier. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-communityroleassignmentscondition) | string | Condition under which the principal can be granted permission. |
| [`principals`](#parameter-communityroleassignmentsprincipals) | array | List of principals to which to assign this role definition. |

### Parameter: `communityRoleAssignments.roleDefinitionId`

Role definition identifier.

- Required: Yes
- Type: string

### Parameter: `communityRoleAssignments.condition`

Condition under which the principal can be granted permission.

- Required: No
- Type: string

### Parameter: `communityRoleAssignments.principals`

List of principals to which to assign this role definition.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`id`](#parameter-communityroleassignmentsprincipalsid) | string | The object id associated with the principal. |
| [`type`](#parameter-communityroleassignmentsprincipalstype) | string | The type of the object id. Users, groups, and service principals are allowed. |

### Parameter: `communityRoleAssignments.principals.id`

The object id associated with the principal.

- Required: Yes
- Type: string

### Parameter: `communityRoleAssignments.principals.type`

The type of the object id. Users, groups, and service principals are allowed.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `diagnosticSettings`

The diagnostic settings of the service.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`eventHubAuthorizationRuleResourceId`](#parameter-diagnosticsettingseventhubauthorizationruleresourceid) | string | Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |
| [`eventHubName`](#parameter-diagnosticsettingseventhubname) | string | Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`logAnalyticsDestinationType`](#parameter-diagnosticsettingsloganalyticsdestinationtype) | string | A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type. |
| [`logCategoriesAndGroups`](#parameter-diagnosticsettingslogcategoriesandgroups) | array | The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection. |
| [`marketplacePartnerResourceId`](#parameter-diagnosticsettingsmarketplacepartnerresourceid) | string | The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs. |
| [`metricCategories`](#parameter-diagnosticsettingsmetriccategories) | array | The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection. |
| [`name`](#parameter-diagnosticsettingsname) | string | The name of the diagnostic setting. |
| [`storageAccountResourceId`](#parameter-diagnosticsettingsstorageaccountresourceid) | string | Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |
| [`workspaceResourceId`](#parameter-diagnosticsettingsworkspaceresourceid) | string | Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub. |

### Parameter: `diagnosticSettings.eventHubAuthorizationRuleResourceId`

Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.eventHubName`

Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logAnalyticsDestinationType`

A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'AzureDiagnostics'
    'Dedicated'
  ]
  ```

### Parameter: `diagnosticSettings.logCategoriesAndGroups`

The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection.

- Required: No
- Type: array

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`category`](#parameter-diagnosticsettingslogcategoriesandgroupscategory) | string | Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here. |
| [`categoryGroup`](#parameter-diagnosticsettingslogcategoriesandgroupscategorygroup) | string | Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs. |
| [`enabled`](#parameter-diagnosticsettingslogcategoriesandgroupsenabled) | bool | Enable or disable the category explicitly. Default is `true`. |

### Parameter: `diagnosticSettings.logCategoriesAndGroups.category`

Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logCategoriesAndGroups.categoryGroup`

Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.logCategoriesAndGroups.enabled`

Enable or disable the category explicitly. Default is `true`.

- Required: No
- Type: bool

### Parameter: `diagnosticSettings.marketplacePartnerResourceId`

The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.metricCategories`

The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`category`](#parameter-diagnosticsettingsmetriccategoriescategory) | string | Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enabled`](#parameter-diagnosticsettingsmetriccategoriesenabled) | bool | Enable or disable the category explicitly. Default is `true`. |

### Parameter: `diagnosticSettings.metricCategories.category`

Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics.

- Required: Yes
- Type: string

### Parameter: `diagnosticSettings.metricCategories.enabled`

Enable or disable the category explicitly. Default is `true`.

- Required: No
- Type: bool

### Parameter: `diagnosticSettings.name`

The name of the diagnostic setting.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.storageAccountResourceId`

Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `diagnosticSettings.workspaceResourceId`

Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.

- Required: No
- Type: string

### Parameter: `dnsServers`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. DNS servers used by the community.

- Required: No
- Type: array

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `firewallSku`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. SKU of the community's Azure Firewall.

- Required: No
- Type: string
- Default: `'Standard'`
- Allowed:
  ```Bicep
  [
    'Basic'
    'Premium'
    'Standard'
  ]
  ```

### Parameter: `governedServiceList`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. List of services governed by the community.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`serviceId`](#parameter-governedservicelistserviceid) | string | Service ID. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enforcement`](#parameter-governedservicelistenforcement) | string | Initiative enforcement (Enabled or Disabled). |
| [`option`](#parameter-governedservicelistoption) | string | Governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable). |
| [`policyAction`](#parameter-governedservicelistpolicyaction) | string | Enforcement mode for policy. |

### Parameter: `governedServiceList.serviceId`

Service ID.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'AKS'
    'AppService'
    'AzureFirewalls'
    'ContainerRegistry'
    'CosmosDB'
    'DataConnectors'
    'Insights'
    'KeyVault'
    'Logic'
    'MicrosoftSQL'
    'Monitoring'
    'PostgreSQL'
    'PrivateDNSZones'
    'ServiceBus'
    'Storage'
  ]
  ```

### Parameter: `governedServiceList.enforcement`

Initiative enforcement (Enabled or Disabled).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `governedServiceList.option`

Governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Allow'
    'Deny'
    'ExceptionOnly'
    'NotApplicable'
  ]
  ```

### Parameter: `governedServiceList.policyAction`

Enforcement mode for policy.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'AuditOnly'
    'Enforce'
    'None'
  ]
  ```

### Parameter: `location`

Location for all resources.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `lock`

The lock settings of the service.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-lockkind) | string | Specify the type of lock. |
| [`name`](#parameter-lockname) | string | Specify the name of lock. |
| [`notes`](#parameter-locknotes) | string | Specify the notes of the lock. |

### Parameter: `lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `lock.notes`

Specify the notes of the lock.

- Required: No
- Type: string

### Parameter: `maintenanceModeConfiguration`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Maintenance Mode configuration.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`mode`](#parameter-maintenancemodeconfigurationmode) | string | Current mode of Maintenance Mode Configuration. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`justification`](#parameter-maintenancemodeconfigurationjustification) | string | Justification for entering or exiting Maintenance Mode. |
| [`principals`](#parameter-maintenancemodeconfigurationprincipals) | array | The user, group or service principal object affected by Maintenance Mode. |

### Parameter: `maintenanceModeConfiguration.mode`

Current mode of Maintenance Mode Configuration.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'Advanced'
    'CanNotDelete'
    'General'
    'Off'
    'On'
  ]
  ```

### Parameter: `maintenanceModeConfiguration.justification`

Justification for entering or exiting Maintenance Mode.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Governance'
    'Networking'
    'Off'
  ]
  ```

### Parameter: `maintenanceModeConfiguration.principals`

The user, group or service principal object affected by Maintenance Mode.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`id`](#parameter-maintenancemodeconfigurationprincipalsid) | string | The object id associated with the principal. |
| [`type`](#parameter-maintenancemodeconfigurationprincipalstype) | string | The type of the object id. Users, groups, and service principals are allowed. |

### Parameter: `maintenanceModeConfiguration.principals.id`

The object id associated with the principal.

- Required: Yes
- Type: string

### Parameter: `maintenanceModeConfiguration.principals.type`

The type of the object id. Users, groups, and service principals are allowed.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `managedIdentities`

The managed identity definition for this resource.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`systemAssigned`](#parameter-managedidentitiessystemassigned) | bool | Enables system assigned managed identity on the resource. |
| [`userAssignedResourceIds`](#parameter-managedidentitiesuserassignedresourceids) | array | The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption. |

### Parameter: `managedIdentities.systemAssigned`

Enables system assigned managed identity on the resource.

- Required: No
- Type: bool

### Parameter: `managedIdentities.userAssignedResourceIds`

The resource ID(s) to assign to the resource. Required if a user assigned identity is used for encryption.

- Required: No
- Type: array

### Parameter: `monitoringSettings`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Community monitoring settings for diagnostic and virtual network flow logs.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`diagnosticDestinations`](#parameter-monitoringsettingsdiagnosticdestinations) | array | Log Analytics workspace destinations where diagnostic logs will be stored. |
| [`flowLogDestination`](#parameter-monitoringsettingsflowlogdestination) | object | Log Analytics workspace destination where virtual network flow logs will be stored. |

### Parameter: `monitoringSettings.diagnosticDestinations`

Log Analytics workspace destinations where diagnostic logs will be stored.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`destinationType`](#parameter-monitoringsettingsdiagnosticdestinationsdestinationtype) | string | The type of monitoring workspace destination. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`customWorkspaceResourceId`](#parameter-monitoringsettingsdiagnosticdestinationscustomworkspaceresourceid) | string | Log Analytics workspace resource ID for a custom workspace. |
| [`diagnosticSettingsName`](#parameter-monitoringsettingsdiagnosticdestinationsdiagnosticsettingsname) | string | Custom name for diagnostic settings. |

### Parameter: `monitoringSettings.diagnosticDestinations.destinationType`

The type of monitoring workspace destination.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'CommunityWorkspace'
    'CustomWorkspace'
    'EnclaveWorkspace'
  ]
  ```

### Parameter: `monitoringSettings.diagnosticDestinations.customWorkspaceResourceId`

Log Analytics workspace resource ID for a custom workspace.

- Required: No
- Type: string

### Parameter: `monitoringSettings.diagnosticDestinations.diagnosticSettingsName`

Custom name for diagnostic settings.

- Required: No
- Type: string

### Parameter: `monitoringSettings.flowLogDestination`

Log Analytics workspace destination where virtual network flow logs will be stored.

- Required: No
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`destinationType`](#parameter-monitoringsettingsflowlogdestinationdestinationtype) | string | The type of monitoring workspace destination. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`customWorkspaceResourceId`](#parameter-monitoringsettingsflowlogdestinationcustomworkspaceresourceid) | string | Log Analytics workspace resource ID for a custom workspace. |
| [`diagnosticSettingsName`](#parameter-monitoringsettingsflowlogdestinationdiagnosticsettingsname) | string | Custom name for diagnostic settings. |

### Parameter: `monitoringSettings.flowLogDestination.destinationType`

The type of monitoring workspace destination.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'CommunityWorkspace'
    'CustomWorkspace'
    'EnclaveWorkspace'
  ]
  ```

### Parameter: `monitoringSettings.flowLogDestination.customWorkspaceResourceId`

Log Analytics workspace resource ID for a custom workspace.

- Required: No
- Type: string

### Parameter: `monitoringSettings.flowLogDestination.diagnosticSettingsName`

Custom name for diagnostic settings.

- Required: No
- Type: string

### Parameter: `policyOverride`

THIS IS A PARAMETER USED FOR A PREVIEW SERVICE/FEATURE, MICROSOFT MAY NOT PROVIDE SUPPORT FOR THIS, PLEASE CHECK THE PRODUCT DOCS FOR CLARIFICATION. Policy override setting for the community.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Enclave'
    'None'
  ]
  ```

### Parameter: `roleAssignments`

Array of Azure RBAC role assignments to create on this resource. Not to be confused with `communityRoleAssignments`, which manages community-scoped access grants.

- Required: No
- Type: array
- Roles configurable by name:
  - `'Contributor'`
  - `'Owner'`
  - `'Reader'`
  - `'Role Based Access Control Administrator'`
  - `'User Access Administrator'`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-roleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | string | The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-roleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container". |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | string | The description of the role assignment. |
| [`name`](#parameter-roleassignmentsname) | string | The name (as GUID) of the role assignment. If not provided, a GUID will be generated. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.roleDefinitionIdOrName`

The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.name`

The name (as GUID) of the role assignment. If not provided, a GUID will be generated.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the community. |
| `resourceGroupName` | string | The name of the resource group the community was created in. |
| `resourceId` | string | The resource ID of the community. |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/utl/types/avm-common-types:0.7.0` | Remote reference |

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft's privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
