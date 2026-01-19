metadata name = 'User-Defined Types library'
metadata description = 'A utility module containing standard, common custom type configurations for Azure modules.'

// ====
// Conventions
// ====

// Convention: Zone
@export()
@description('Required. Zone name ')
type zoneNameType = {
  @description('Required. Full zone name')
  full : string
  @description('Required. Short zone name')
  short: string
}

// ====
// Generic resource definitions
// ====

// Generic: Subresource
@export()
@description('The type for the sub resource.')
type subResourceType = {
  @description('Optional. Resource ID of the sub resource.')
  id: string?
}

// Generic: Locks
@export()
@description('An AVM-aligned type for a lock.')
type lockType = {
  @description('Optional. Specify the name of lock.')
  name: string?

  @description('Optional. Specify the type of lock.')
  kind: ('CanNotDelete' | 'ReadOnly' | 'None')?

  @description('Optional. Specify the notes of the lock.')
  notes: string?
}

// ====
// Diagnostic Settings
// ====

// Diagnostics: Full
@export()
@description('An AVM-aligned type for a diagnostic setting. To be used if both logs & metrics are supported by the resource provider.')
type diagnosticSettingFullType = {
  @description('Optional. The name of the diagnostic setting.')
  name: string?

  @description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection.')
  logCategoriesAndGroups: {
    @description('Optional. Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.')
    category: string?

    @description('Optional. Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs.')
    categoryGroup: string?

    @description('Optional. Enable or disable the category explicitly. Default is `true`.')
    enabled: bool?
  }[]?

  @description('Optional. The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection.')
  metricCategories: {
    @description('Required. Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics.')
    category: string

    @description('Optional. Enable or disable the category explicitly. Default is `true`.')
    enabled: bool?
  }[]?

  @description('Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.')
  logAnalyticsDestinationType: ('Dedicated' | 'AzureDiagnostics')?

  @description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  workspaceResourceId: string?

  @description('Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  storageAccountResourceId: string?

  @description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
  eventHubAuthorizationRuleResourceId: string?

  @description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  eventHubName: string?

  @description('Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.')
  marketplacePartnerResourceId: string?
}

// Diagnostics: Metrics-only
@export()
@description('An AVM-aligned type for a diagnostic setting. To be used if only metrics are supported by the resource provider.')
type diagnosticSettingMetricsOnlyType = {
  @description('Optional. The name of diagnostic setting.')
  name: string?

  @description('Optional. The name of metrics that will be streamed. "allMetrics" includes all possible metrics for the resource. Set to `[]` to disable metric collection.')
  metricCategories: {
    @description('Required. Name of a Diagnostic Metric category for a resource type this setting is applied to. Set to `AllMetrics` to collect all metrics.')
    category: string

    @description('Optional. Enable or disable the category explicitly. Default is `true`.')
    enabled: bool?
  }[]?

  @description('Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.')
  logAnalyticsDestinationType: ('Dedicated' | 'AzureDiagnostics')?

  @description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  workspaceResourceId: string?

  @description('Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  storageAccountResourceId: string?

  @description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
  eventHubAuthorizationRuleResourceId: string?

  @description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  eventHubName: string?

  @description('Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.')
  marketplacePartnerResourceId: string?
}

// Diagnostics: Logs-only
@export()
@description('An AVM-aligned type for a diagnostic setting. To be used if only logs are supported by the resource provider.')
type diagnosticSettingLogsOnlyType = {
  @description('Optional. The name of diagnostic setting.')
  name: string?

  @description('Optional. The name of logs that will be streamed. "allLogs" includes all possible logs for the resource. Set to `[]` to disable log collection.')
  logCategoriesAndGroups: {
    @description('Optional. Name of a Diagnostic Log category for a resource type this setting is applied to. Set the specific logs to collect here.')
    category: string?

    @description('Optional. Name of a Diagnostic Log category group for a resource type this setting is applied to. Set to `allLogs` to collect all logs.')
    categoryGroup: string?

    @description('Optional. Enable or disable the category explicitly. Default is `true`.')
    enabled: bool?
  }[]?

  @description('Optional. A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type.')
  logAnalyticsDestinationType: ('Dedicated' | 'AzureDiagnostics')?

  @description('Optional. Resource ID of the diagnostic log analytics workspace. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  workspaceResourceId: string?

  @description('Optional. Resource ID of the diagnostic storage account. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  storageAccountResourceId: string?

  @description('Optional. Resource ID of the diagnostic event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
  eventHubAuthorizationRuleResourceId: string?

  @description('Optional. Name of the diagnostic event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. For security reasons, it is recommended to set diagnostic settings to send data to either storage account, log analytics workspace or event hub.')
  eventHubName: string?

  @description('Optional. The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.')
  marketplacePartnerResourceId: string?
}

// ====
// Azure Monitor
// ====

// Data Collection
@description('Data collection configuraiton.')
type dataCollection = { 
  @description('Required. Resource group that contains data collection rules and endpoints')
  resourceGroupName: string

  @description('Optional. Subscription ID where resourceGroup is found')
  subscriptionId: string

  @description('Required. Data collection rule')
  dataCollectionRuleName: string

  @description('Required. Data collection rule')
  dataCollectionEndpointName: string

  @description('Optional. Private dns subscription ID')
  privateDnsSubscriptionId: string?
}?

// Log Analytics: Workspace Configuration
@export()
@description('A common Log Analytics configuration type.')
type logAnalyticsConfigType = {
  @description('Optional. The name of the SKU.')
  skuName: (
    | 'CapacityReservation'
    | 'Free'
    | 'LACluster'
    | 'PerGB2018'
    | 'PerNode'
    | 'Premium'
    | 'Standalone'
    | 'Standard'
    | null)

  @description('Optional. Number of days data will be retained for.')
  dataRetention: int?

  @description('Optional. The network access type for accessing Log Analytics ingestion.')
  publicNetworkAccessForIngestion: ('Disabled' | 'Enabled')

  @description('Optional. The network access type for accessing Log Analytics query.')
  publicNetworkAccessForQuery: ('Disabled' | 'Enabled')

  @description('Optional. Set to "true" to use resource or workspace permissions and "false" (or leave empty) to require workspace permissions.')
  useResourcePermissions: bool?
}?

// ====
// Azure HSM & Key Vault
// ====

@export()
@description('Key Vault configuration.')
type keyVaultType = {
  @description('Optional. Name for the Keyvault. Defaults to "nameprefix-kv" if not set.')
  name: string?

  @description('Optional. The SKU of the KeyVault.')
  sku: ('standard' | 'premium')?

  @description('Optional. Enable purge protection for the KeyVault.')
  enablePurgeProtection: bool?

  @description('Optional. Enable soft delete')
  enableSoftDelete: bool?

  @description('Optional. Sets soft delete retention (days)')
  softDeleteRetentionInDays: int?

  @description('Optional. Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions.')
  enableRbacAuthorization: bool?

  @description('Optional. Private Endpoint Configuration')
  privateEndpointConfig: privateEndpointType[]?

  @description('Optional. Key object to set custom key values')
  key: keyType?

  @description('Optional. The diagnostic settings of the service.')
  diagnosticSettings: diagnosticSettingFullType[]?
}

// Key Vault: Key
@export()
@description('Key Vault key configuration.')
type keyType = {
  @description('Optional. Specify the name of the key.')
  name: string?

  @description('Optional. Contains attributes of the key.')
  attributes: {
    @description('Optional. Defines whether the key is enabled or disabled.')
    enabled: bool?

    @description('Optional. Defines when the key will become invalid. Defined in seconds since 1970-01-01T00:00:00Z.')
    exp: int?

    @description('Optional. If set, defines the date from which onwards the key becomes valid. Defined in seconds since 1970-01-01T00:00:00Z.')
    nbf: int?
  }?

  @description('Optional. The elliptic curve name. Only works if "keySize" equals "EC" or "EC-HSM". Default is "P-256".')
  curveName: ('P-256' | 'P-256K' | 'P-384' | 'P-521')?

  @description('Optional. The allowed operations on this key.')
  keyOps: ('decrypt' | 'encrypt' | 'import' | 'release' | 'sign' | 'unwrapKey' | 'verify' | 'wrapKey')[]?

  @description('Optional. The key size in bits. Only works if "keySize" equals "RSA" or "RSA-HSM". Default is "4096".')
  keySize: (2048 | 3072 | 4096)?

  @description('Optional. The type of the key. Default is "EC".')
  kty: ('EC' | 'EC-HSM' | 'RSA' | 'RSA-HSM')?

  @description('Optional. Key rotation policy.')
  rotationPolicy: rotationPolicyType?

  @description('Optional. Array of role assignments to create.')
  roleAssignments: roleAssignmentType[]?
}

// Key Vault: Key: Rotation Policy
@export()
@description('Key Vault rotation policy.')
type rotationPolicyType = {
  @description('Optional. The attributes of key rotation policy.')
  attributes: {
    @description('Optional. The expiration time for the new key version. It should be in ISO8601 format. Eg: "P90D", "P1Y".')
    expiryTime: string?
  }?

  @description('Optional. The key rotation policy lifetime actions.')
  lifetimeActions: {
    @description('Optional. The type of the action.')
    action: {
      @description('Optional. The type of the action.')
      type: ('rotate' | 'notify')?
    }?

    @description('Optional. The time duration for rotating the key.')
    trigger: {
      @description('Optional. The time duration after key creation to rotate the key. It only applies to rotate. It will be in ISO 8601 duration format. Eg: "P90D", "P1Y".')
      timeAfterCreate: string?

      @description('Optional. The time duration before key expiring to rotate or notify. It will be in ISO 8601 duration format. Eg: "P90D", "P1Y".')
      timeBeforeExpiry: string?
    }?
  }[]?
}

// ====
// Azure Storage
// ====

// Storage Account: Secrets Export
@export()
@description('Storage Account account keys and connection string export')
type secretsExportConfigurationType = {
  @description('Required. Exports access keys and connection strings to a Keyvault')
  exportStorageSecrets: bool

  @description('Optional. ResourceID of a Keyvault to store the secrets in. Defaults to module created keyvault if this value is not set.')
  keyVaultResourceId: string?

  @description('Optional. The accessKey1 secret name to create.')
  accessKey1Name: string?

  @description('Optional. The connectionString1 secret name to create.')
  connectionString1Name: string?

  @description('Optional. The accessKey2 secret name to create.')
  accessKey2Name: string?

  @description('Optional. The connectionString2 secret name to create.')
  connectionString2Name: string?
}

// Storage Account
@export()
@description('The type for Storage Account.')
type storageAccountType = {
  @description('Required. Enables Storage Account')
  enabled: bool

  @description('Optional. Name of the storage account')
  name: string?

  @description('Optional. Kind of storage account')
  kind: 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage' | 'Storage' | 'StorageV2'?

  @description('Optional. Sku Type')
  sku:
    | 'Premium_LRS'
    | 'Premium_ZRS'
    | 'Standard_GRS'
    | 'Standard_GZRS'
    | 'Standard_LRS'
    | 'Standard_RAGRS'
    | 'Standard_RAGZRS'
    | 'Standard_ZRS'?

  @description('Optional. Assigns storage permissions to Entra Group.')
  entraAVDUserGroup: string?

  @description('Optional. Sets the Azure files identity based authentication')
  azureFilesIdentityBasedAuthentication: {
    @description('Required. Indicates the directory service used.')
    directoryServiceOptions: 'AADDS' | 'AADKERB' | 'AD' | 'None'

    @description('Optional. Default share permission for users using Kerberos authentication if RBAC role is not assigned.')
    defaultSharePermission:
      | 'None'
      | 'StorageFileDataSmbShareContributor'
      | 'StorageFileDataSmbShareElevatedContributor'
      | 'StorageFileDataSmbShareReader'?

    @description('Required if directoryServiceOptions are AD, optional if they are AADKERB.')
    activeDirectoryProperties: object?
  }?

  @description('Optional. Defines the protocol settings for fileshares')
  protocolSettings: object?

  @description('Optional. Soft delete retention policy')
  shareDeleteRetentionPolicy: object?

  @description('Optional. Shares to create in storage account')
  shares: sharesType[]?

  @description('Optional. Private Endpoint Configuration Object')
  privateEndpointConfig: privateEndpointType[]?

  @description('Conditional. If true, enables Hierarchical Namespace for the storage account. Required if enableSftp or enableNfsV3 is set to true.')
  enableHierarchicalNamespace: bool?

  @description('Optional. If true, enables Secure File Transfer Protocol for the storage account. Requires enableHierarchicalNamespace to be true.')
  enableSftp: bool?

  @description('Optional. Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is null, which is equivalent to true.')
  allowSharedKeyAccess: bool?

  @description('Optional. Set the minimum TLS version on request to storage. The TLS versions 1.0 and 1.1 are deprecated and not supported anymore.')
  minimumTlsVersion: 'TLS1_2'?

  @description('Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set and networkAcls are not set.')
  publicNetworkAccess: ('Enabled' | 'Disabled')?

  @description('Optional. A Boolean indicating whether or not the service applies a secondary layer of encryption with platform managed keys for data at rest. For security reasons, it is recommended to set it to true.')
  requireInfrastructureEncryption: bool?
}

// File Share
@export()
@description('The type for File Shares configuration.')
type sharesType = {
  @description('Required. Name of the file share.')
  name: string

  @description('Optional. Specifies the access tier for the file share. Valid values are "Cool", "Hot", "Premium", or "TransactionOptimized".')
  accessTier: 'Cool' | 'Hot' | 'Premium' | 'TransactionOptimized'?

  @description('Required. Specifies the enabled protocol for the share.')
  enabledProtocols: 'SMB'

  @description('Optional. Specifies the paid bursting configuration for the file share. This is an object containing bursting-related properties.')
  fileSharePaidBursting: object?

  @description('Optional. Metadata key-value pairs associated with the file share.')
  metadata: object?

  @description('Optional. Provisioned bandwidth in MiBps for the file share. This is relevant for premium file shares.')
  provisionedBandwidthMibps: int?

  @description('Optional. Provisioned IOPS (Input/Output Operations Per Second) for the file share. This is relevant for premium file shares.')
  provisionedIops: int?

  @description('Required. Specifies the maximum size of the file share in GiB.')
  shareQuota: int

  @description('Optional. Specifies a list of shared access policies (signed identifiers) for the file share.')
  signedIdentifiers: array?
}

// ====
// Azure Networking
// ====

// Virtual Network
@export()
@description('Virtual Network configuration')
type vnetType = {
  @description('Required. Name of the virtual network.')
  vnetName: string

  @description('Required. Resource Group of the virtual network.')
  resourceGroup: string

  @description('Optional. Name of the subnet to be used.')
  destinationSubnet: string?
}

// Network Interface:
@export()
@description('Defines the complete network interface configuration.')
type nicConfigurationType = {
  @description('Optional. The diagnostic settings for the NIC.')
  diagnosticSettings: diagnosticSettingFullType[]?

  @description('Optional. The list of DNS servers for the NIC.')
  dnsServers: array?

  @description('Optional. Specifies whether accelerated networking is enabled.')
  enableAcceleratedNetworking: bool?

  @description('Optional. Specifies whether IP forwarding is enabled.')
  enableIPForwarding: bool?

  @description('Optional. The name of the IP configuration.')
  ipConfigName: string?

  @description('Optional. Defines the IP configuration settings for a network interface (Private).')
  privateIpConfiguration: {
    @description('Optional. Specifies the allocation method for the private IP address. Possible values are Static or Dynamic.')
    privateIPAllocationMethod: 'Static' | 'Dynamic'?

    @description('Optional. Specifies the private IP address if a Static allocation method is used.')
    privateIPAddress: string?

    @description('Optional. The private IP address version. Possible values are IPv4 or IPv6.')
    privateIPAddressVersion: 'IPv4' | 'IPv6'?

    @description('Optional. The resource ID of the subnet this IP configuration is attached to.')
    subnetResourceId: string?

    @description('Optional. The associated application security groups.')
    applicationSecurityGroups: array?
  }?

  @description('Defines the public IP configuration settings.')
  publicIpConfiguration: {
    @description('Optional. The name of the public IP')
    name: string?

    @description('Optional. The allocation method for the public IP address. Possible values are Static or Dynamic.')
    publicIPAllocationMethod: 'Static' | 'Dynamic'?

    @description('Optional. The public IP address version. Possible values are IPv4 or IPv6.')
    publicIPAddressVersion: 'IPv4' | 'IPv6'?
  }?
}?

// Network Interface: IP address config
@export()
@description('Defines the IP Configuration settings.')
type ipConfigurationType = {
  @description('Required. The name of the IP configuration.')
  name: string

  @description('Optional. Specifies the allocation method for the private IP address. Possible values are Static or Dynamic.')
  privateIPAllocationMethod: 'Static' | 'Dynamic'

  @description('Optional. Specifies the private IP address if a Static allocation method is used.')
  privateIPAddress: string?

  @description('Optional. The private IP address version. Possible values are IPv4 or IPv6.')
  privateIPAddressVersion: 'IPv4' | 'IPv6'

  @description('Required. The resource ID of the subnet this IP configuration is attached to.')
  subnetResourceId: string

  @description('Optional. The associated application security groups.')
  applicationSecurityGroups: array?

  @description('Defines the public IP configuration settings.')
  pipConfiguration: publicIpConfigurationType?
}

// Private DNS Zone: Existing DNS Zone
@description('Private DNS Zone Type')
type privateDnsZoneExistingType = {
  @description('Required. The name of the private DNS zone.')
  resourceGroupName: string

  @description('Optional. The subscription ID of the private DNS zone.')
  privateDnsSubscriptionId: string?
}

// Private Endpoint
@export()
@description('An AVM-aligned type for a private endpoint.')
type privateEndpointType = {
  @description('Optional. The name of the Private Endpoint.')
  name: string?

  @description('Required. Enables private endpoint(s).')
  enabled: bool

  @description('Optional. The location to deploy the Private Endpoint to.')
  location: string?

  @description('Optional. The name of the private link connection to create.')
  privateLinkServiceConnectionName: string?

  @description('Optional. The subresource to deploy the Private Endpoint for. For example "vault" for a Key Vault Private Endpoint.')
  service: string?

  @description('Required. Resource ID of the subnet where the endpoint needs to be created.')
  subnetResourceId: string

  @description('Optional. The resource ID of the Resource Group the Private Endpoint will be created in. If not specified, the Resource Group of the provided Virtual Network Subnet is used.')
  resourceGroupResourceId: string?

  @description('Optional. The private DNS Zone Group to configure for the Private Endpoint.')
  privateDnsZoneGroup: privateEndpointPrivateDnsZoneGroupType?

  @description('Optional. If Manual Private Link Connection is required.')
  isManualConnection: bool?

  @description('Optional. A message passed to the owner of the remote resource with the manual connection request.')
  @maxLength(140)
  manualConnectionRequestMessage: string?

  @description('Optional. Custom DNS configurations.')
  customDnsConfigs: privateEndpointCustomDnsConfigType[]?

  @description('Optional. A list of IP configurations of the Private Endpoint. This will be used to map to the first-party Service endpoints.')
  ipConfigurations: privateEndpointIpConfigurationType[]?

  @description('Optional. Application security groups in which the Private Endpoint IP configuration is included.')
  applicationSecurityGroupResourceIds: string[]?

  @description('Optional. The custom name of the network interface attached to the Private Endpoint.')
  customNetworkInterfaceName: string?

  @description('Optional. Specify the type of lock.')
  lock: lockType?

  @description('Optional. Tags to be applied on all resources/Resource Groups in this deployment.')
  tags: object?

  @description('Optional. Enable/Disable usage telemetry for module.')
  enableTelemetry: bool?
}

// Private Endpoint: DNS Zone
@export()
@description('Private Endpoint DNS zone configuration')
type privateEndpointPrivateDnsZoneGroupType = {
  @description('Optional. The name of the Private DNS Zone Group.')
  name: string?

  @description('Required. The private DNS Zone Groups to associate the Private Endpoint. A DNS Zone Group can support up to 5 DNS zones.')
  privateDnsZoneGroupConfigs: {
    @description('Optional. The name of the private DNS Zone Group config.')
    name: string?

    @description('Required. The resource id of the private DNS zone.')
    privateDnsZoneResourceId: string
  }[]
}

// Private Endpoint: DNS record
@export()
@description('Private Endpoint DNS record configuration')
type privateEndpointCustomDnsConfigType = {
  @description('Optional. FQDN that resolves to private endpoint IP address.')
  fqdn: string?

  @description('Required. A list of private IP addresses of the private endpoint.')
  ipAddresses: string[]
}

// Private Endpoint: IP address
@export()
@description('Private Endpoint IP address configuration')
type privateEndpointIpConfigurationType = {
  @description('Required. The name of the resource that is unique within a resource group.')
  name: string

  @description('Required. Properties of private endpoint IP configurations.')
  properties: {
    @description('Required. The ID of a group obtained from the remote resource that this private endpoint should connect to.')
    groupId: string

    @description('Required. The member name of a group obtained from the remote resource that this private endpoint should connect to.')
    memberName: string

    @description('Required. A private IP address obtained from the private endpoint\'s subnet.')
    privateIPAddress: string
  }
}

// Public IP Address
@export()
@description('Defines the public IP configuration settings.')
type publicIpConfigurationType = {
  @description('Required. The name of the Public IP Address')
  name: string
  
  @description('Optional. The allocation method for the public IP address. Possible values are Static or Dynamic.')
  publicIPAllocationMethod: 'Static' | 'Dynamic'?
  
  @description('Optional. The public IP address version. Possible values are IPv4 or IPv6.')
  publicIPAddressVersion: 'IPv4' | 'IPv6'?
  
  @description('Optional. Resource ID of the Public IP Prefix object. This is only needed if you want your Public IPs created in a PIP Prefix.')
  publicIpPrefixResourceId: string?
}?

// ====
// Azure Identity
// ====

// User-Assigned Managed Identity
@export()
@description('Allows for the creation of a User Assigned Managed Identity')
type userAssignedManagedIdentityType = {
  @description('Required. Sets the creation of a UAMI')
  newUami: bool

  @description('Optional. Name of UAMI')
  name: string?
}

// Role Assignments
@export()
@description('An AVM-aligned type for a role assignment.')
type roleAssignmentType = {
  @description('Optional. The name (as GUID) of the role assignment. If not provided, a GUID will be generated.')
  name: string?

  @description('Required. The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.')
  roleDefinitionIdOrName: string

  @description('Required. The principal ID of the principal (user/group/identity) to assign the role to.')
  principalId: string

  @description('Optional. The principal type of the assigned principal ID.')
  principalType: ('ServicePrincipal' | 'Group' | 'User' | 'ForeignGroup' | 'Device')?

  @description('Optional. The description of the role assignment.')
  description: string?

  @description('Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".')
  condition: string?

  @description('Optional. Version of the condition.')
  conditionVersion: '2.0'?

  @description('Optional. The Resource Id of the delegated managed identity resource.')
  delegatedManagedIdentityResourceId: string?
}[]

// ====
// Azure Compute (inc AVD)
// ====

// Availability Set
@export()
@description('Defines the availability Set options')
type availabilitySetType = {
  @description('Optional. The number of fault domains to use.')
  faultDomainCount: int?

  @description('Optional. The number of update domains to use.')
  updateDomainCount: int?
}?

// Virtual Desktop: Application Group
@export()
@description('Azure Virtual Desktop Application Group configuration.')
type avdAppGroupType = {
  @description('Optional. Friendly name for the application group.')
  friendlyName: string?

  @description('Optional. Description of the application group.')
  description: string?

  @description('Optional. Type of the application group.')
  applicationGroupType: ('RemoteApp' | 'Desktop')?

  @description('Optional. Principal IDs of Entra Groups to allow user logins.')
  entraGroupsPrincipalIds: array?

  @description('Optional. The diagnostic settings of the service.')
  diagnosticSettings: diagnosticSettingLogsOnlyType[]?
}

// Virtual Desktop: Host Pool
@export()
@description('Azure Virtual Desktop Host Pool configuration.')
type avdHostPoolType = {
  @description('Optional. Name for the Host Pool. Defaults to "<name-prefix>-hp" if not set.')
  name: string?

  @description('Optional. Description of the host pool.')
  description: string?

  @description('Optional. Friendly name for the host pool.')
  friendlyName: string?

  @description('Optional. The type of host pool (e.g., Pooled or Personal).')
  hostPoolType: ('Pooled' | 'Personal')?

  @description('Optional. Set Public Network Access')
  publicNetworkAccess: ('Disabled' | 'Enabled' | 'EnabledForClientsOnly' | 'EnabledForSessionHostsOnly')?

  @description('Optional. Preferred application group type (e.g., Desktop or RemoteApp).')
  preferredAppGroupType: ('Desktop' | 'None' | 'RailApplications')?

  @description('Required. Number of session hosts for the host pool')
  sessionHostCount: int

  @description('Optional. Custom RDP properties.')
  customRdpProperty: string?

  @description('Optional. Whether this is a validation environment.')
  validationEnvironment: bool?

  @description('Optional. Virtual machine template for session hosts.')
  vmTemplate: object?

  @description('Optional. Maximum session limit per user.')
  maxSessionLimit: int?

  @description('Optional. Load balancer type (e.g., BreadthFirst, DepthFirst).')
  loadBalancerType: ('BreadthFirst' | 'DepthFirst' | 'Persistent')?

  @description('Optional. Whether to start the VM on connect.')
  startVMOnConnect: bool?

  @description('Optional. Agent update settings.')
  agentUpdate: object?

  @description('Optional. Assignment type for personal desktops (e.g., Automatic, Direct).')
  personalDesktopAssignmentType: ('Automatic' | 'Direct')?

  @description('Optional. ADFS authority for SSO.')
  ssoAdfsAuthority: string?

  @description('Optional. Client ID for SSO.')
  ssoClientId: string?

  @description('Optional. Key Vault path for SSO client secret.')
  ssoClientSecretKeyVaultPath: string?

  @description('Optional. SSO secret type.')
  ssoSecretType: ('Certificate' | 'CertificateInKeyVault' | 'SharedKey' | 'SharedKeyInKeyVault')?

  @description('Optional. Private Endpoint Configuration Object')
  privateEndpointConfig: privateEndpointType[]?

  @description('Optional. The diagnostic settings of the service.')
  diagnosticSettings: diagnosticSettingLogsOnlyType[]?

  @description('Optional. The lock settings of the service.')
  lock: lockType?

  @description('Required. The type of management for this hostpool. Note: If set to `Automated`, no registrationToken is returned by the resource.')
  managementType: ('Standard' | 'Automated')

  @description('Optional. Array of role assignments to create.')
  roleAssignments: roleAssignmentType[]?

  @description('Optional. Where direct UDP connectivity is established between the client and the session host when using a private connection, such as a virtual private network (VPN). Default: AVD-wide settings are used to determine connection availability. Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type<br>- Disabled: UDP will not attempt this connection type when making connections.')
  directUDP: ('Default' | 'Disabled' | 'Enabled')?

  @description('Optional. Enable/Disable usage telemetry for module.')
  enableTelemetry: bool?

  @description('Optional. Where direct UDP connectivity is established between the client and the session host when using a private connection, such as a virtual private network (VPN). Default: AVD-wide settings are used to determine connection availability. Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type. Disabled: UDP will not attempt this connection type when making connections.')
  managedPrivateUDP: ('Default' | 'Disabled' | 'Enabled')?

  @description('Optional. Where direct UDP connectivity is established between the client and the session host via public network using Simple Traversal Underneath NAT (STUN) protocol.<br>- Default: AVD-wide settings are used to determine connection availability<br>- Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type<br>- Disabled: UDP will not attempt this connection type when making connections.')
  publicUDP: ('Default' | 'Disabled' | 'Enabled')?

  @description('Optional. Where indirect UDP connectivity is established between the client and the session host via public network using Traversal Using Relay NAT (TURN) protocol.<br>- Default: AVD-wide settings are used to determine connection availability<br>- Enabled: UDP will attempt this connection type when making connections. This means that this connection is possible, but is not guaranteed, as there are other factors that may prevent this connection type<br>- Disabled: UDP will not attempt this connection type when making connections.')
  relayUDP: ('Default' | 'Disabled' | 'Enabled')?

  @description('Optional. The ring number of HostPool.')
  ring: int?

  @description('Optional. Host Pool token validity length. Usage: \'PT8H\' - valid for 8 hours; \'P5D\' - valid for 5 days; \'P1Y\' - valid for 1 year. When not provided, the token will be valid for 8 hours.')
  tokenValidityLength: string?
}

// Virtual Desktop: Session Host Registration
@export()
@description('Azure Virtual Desktop session host registration settings.')
type sessionHostRegistrationType = {
  @description('Optional. Powershell command that references the script and function to execute.')
  configurationFunction: string?

  @description('Optional. Specifies if registration should also join Entra (AAD)')
  aadJoin: bool?

  @description('Optional. Zip version number of the session host registration modules URL')
  modulesUrlZipVersion: string?
}

// Virtual Desktop: Workspace
@export()
@description('Azure Virtual Desktop Workspace configuration.')
type avdWorkspaceType = {
  @description('Optional. References to associated application groups.')
  applicationGroupReferences: array?

  @description('Optional. Description of the workspace.')
  description: string?

  @description('Optional. Friendly name for the workspace.')
  friendlyName: string?

  @description('Optional. Public network access setting. If disabled private endpoint is configured')
  publicNetworkAccess: ('Disabled' | 'Enabled')?

  @description('Optional. Private Endpoint Configuration')
  privateEndpoints: privateEndpointType[]?

  @description('Optional. Defined Diagnostic settings for AVD')
  diagnosticSetting: diagnosticSettingLogsOnlyType[]?
}

// Virtual Machine
@export()
@description('Virtual Machine (OS-agnostic)')
type virtualMachineType = {
  @description('Required. Name of virtual machine; used for NICs and Disks.')
  name: string

  @description('Optional. Sets the location for the virtual machine')
  location: 'australiaeast' | 'australiasoutheast' | 'australiacentral' | 'australiacentral2'?

  @description('Optional. Availability Zone number to deploy VM to.')
  zone: 0 | 1 | 2 | 3?

  @description('Optional. Azure VM SKU.')
  sku: string?

  @description('Optional. VM Identity configuration.')
  managedIdentities: {
    @description('Optional. Enables system assigned managed identity on the resource.')
    systemAssigned: bool?

    @description('Optional. The resource ID(s) to assign to the resource.')
    userAssignedResourceIds: string[]?
  }?

  @description('Optional. VM OS Disk configuration.')
  osDisk: {
    @description('Optional. Size of OS disk in GB.')
    size: int?

    @description('Optional. Storage performance tier of disk.')
    storageType: 'Premium_LRS' | 'StandardSSD_LRS' | 'Standard_LRS'?

    @description('Optional. Specifies how the virtual machine should be created.')
    createOption: 'Attach' | 'Empty' | 'FromImage'?

    @description('Optional. Specifies whether data disk should be deleted or detached upon VM deletion.')
    deleteOption: 'Delete' | 'Detach'?

    @description('Optional. Specifies the caching requirements.')
    caching: 'None' | 'ReadOnly' | 'ReadWrite'?
  }?

  @description('Optional. Data Disks for VM, if any.')
  dataDisks: dataDiskType[]?

  securityConfiguration: {
    @description('Optional. Sets security type')
    securityType: 'ConfidentialVM' | 'TrustedLaunch'?

    @description('Optional. Specifies whether secure boot should be enabled on the virtual machine.')
    secureBootEnabled: bool?

    @description('Optional. Specifies whether vTPM should be enabled on the virtual machine.')
    vTpmEnabled: bool?
  }?

  @description('Required. Admin Username')
  adminUsername: string

  @description('Required. Admin password, only required for Windows Virtual Machines')
  @secure()
  adminPassword: string

  @description('Optional. Custom data')
  customData: string?

  @description('Optional. This property can be used to enable or disable the Host Encryption for the virtual machine. This will enable the encryption for all the disks including Resource/Temp disk at host itself. Restrictions: Cannot be enabled if Azure Disk Encryption is enabled on your VMs.')
  encryptionAtHost: bool?

  @description('Optional. Configuration settings for Windows VMs.')
  windowsConfiguration: {
    @description('Optional. Specifies whether the VM Agent should be provisioned.')
    provisionVMAgent: bool?

    @description('Optional. Specifies whether automatic updates are enabled.')
    enableAutomaticUpdates: bool?

    @description('Optional. License type for hybrid-use benefit.')
    licenseType: 'Windows_Client' | 'Windows_Server' | 'RHEL_BYOS' | 'SLES_BYOS'?

    @description('Optional. Configuration for automatic patching.')
    patchSettings: {
      @description('Optional. Specifies the patch mode for the VM.')
      patchMode: 'AutomaticByPlatform' | 'AutomaticByOS' | 'Manual'?

      @description('Optional. Specifies the patch assessment mode.')
      assessmentMode: string?

      @description('Optional. Specifies whether hotpatching is enabled.')
      enableHotpatching: bool?

      @description('Optional. Settings for AutomaticByPlatform mode.')
      automaticByPlatformSettings: {
        @description('Optional. Bypass platform safety checks on user schedule.')
        bypassPlatformSafetyChecksOnUserSchedule: bool?

        @description('Optional. Specifies the reboot setting for patching.')
        rebootSetting: string?
      }?
    }?

    @description('Optional. Windows VM time zone configuration.')
    timeZone: string?

    @description('Optional. Additional unattend content for Windows setup.')
    additionalUnattendContent: array?

    @description('Optional. Windows Remote Management (WinRM) settings.')
    winRM: {
      @description('Optional. List of WinRM listeners.')
      listeners: array?
    }?
  }?

  @description('Optional. Network configuration for the virtual machine NIC')
  nicConfiguration: nicConfigurationType?

  @description('Optional. Enables Anti Malware extension for the virtual machine.')
  antiMalwareEnable: bool?

  @description('Optional. Enables Azure Disk Encryption for the virtual machine.')
  azureDiskEncryptionEnable: bool?

  @description('Optional. Extension Configuration Object for Domain Join')
  domainJoinConfig: {
    @description('Required. Enable extension')
    enabled: bool

    @description('Required. Domain name to join')
    domainName: string

    @description('Optional. OU Path where computer object will be created.')
    ouPath: string?

    @description('Required. Username with domain join privileges')
    domainUsername: string

    @description('Required. Password for domain join useraccount')
    @secure()
    domainPassword: string
  }?

  @description('Optional. Enables Azure Monitor Agent for the Virtual Machine.')
  monitorAgentEnable: bool?

  @description('Optional. Enables AAD Login')
  aadJoinEnabled: bool?
}

// Virtual Machine: Image
@export()
@description('Virtual Machine Image reference Type')
type virtualMachineImageType = {
  @description('Optional. Resource ID of the image in use, such as a Compute Gallery image.')
  id: string?

  @description('Optional. Name of the image publisher; used in combination with Sku, Offer, and Version.')
  publisher: string?

  @description('Optional. Name of the image publisher; used in combination with Publisher, Offer, and Version.')
  sku: string?

  @description('Optional. Name of the image publisher; used in combination with Publisher, Sku, and Version.')
  offer: string?

  @description('Optional. Name of the image publisher; used in combination with Publisher, Sku, and Offer.')
  version: string?
}

// Virtual Machine: Plan
@export()
@description('Virtual Machine Marketplace Image Type')
type virtualMachinePlanType = {
  @description('Optional. The name of the plan.')
  name: string?

  @description('Optional. Specifies the product of the image from the marketplace.')
  product: string?

  @description('Optional. The publisher ID.')
  publisher: string?

  @description('Optional. The promotion code.')
  promotionCode: string?
}

// Virtual Machine: Windows
@export()
@description('Virtual Machine (Windows) configuration')
type windowsConfigScopeType = {
  @description('Virtual Machine OS Type used for custom OS configuration options')
  type: 'Windows'
  
  @description('Required. Admin Username')
  adminUsername: string

  @description('Required. Admin password, only required for Windows Virtual Machines')
  @secure()
  adminPassword: string

  @description('Optional. Specifies whether the VM Agent should be provisioned.')
  provisionVMAgent: bool?

  @description('Optional. Specifies whether automatic updates are enabled.')
  enableAutomaticUpdates: bool?

  @description('Optional. License type for hybrid-use benefit.')
  licenseType: 'Windows_Client' | 'Windows_Server' | 'RHEL_BYOS' | 'SLES_BYOS'?

  @description('Optional. Windows VM time zone configuration.')
  timeZone: string?

  @description('Optional. Additional unattend content for Windows setup.')
  additionalUnattendContent: array?

  @description('Optional. Windows Remote Management (WinRM) settings.')
  winRMListenerType: {
    @description('Optional. The URL of a certificate that has been uploaded to Key Vault as a secret.')
    certificateUrl: string?

    @description('Optional. Specifies the protocol of WinRM listener.')
    protocol: 'Http' | 'Https'?	
  }[]?

  @description('Optional. Configuration for automatic patching.')
  patchSettings: {
    @description('Optional. Specifies the patch mode for the VM.')
    patchMode: 'AutomaticByPlatform' | 'AutomaticByOS' | 'Manual'?

    @description('Optional. Specifies the patch assessment mode.')
    assessmentMode: 'AutomaticByPlatform' | 'ImageDefault'

    @description('Optional. Specifies whether hot patching is enabled.')
    enableHotPatching: bool?

    @description('Optional. Bypass platform safety checks on user schedule.')
    bypassPlatformSafetyChecksOnUserSchedule: bool?

    @description('Optional. Specifies the reboot setting for patching.')
    rebootSetting: 'Always' | 'IfRequired' | 'Never' | 'Unknown'
  }?
}

// Virtual Machine: Linux
@export()
@description('Virtual Machine (Linux) configuration')
type linuxConfigScopeType = {
  @description('Virtual Machine OS Type used for custom OS configuration options')
  type: 'Linux'
  
  @description('Required. Admin Username')
  adminUsername: string

  @description('Optional. Admin password, only required for Windows Virtual Machines')
  @secure()
  adminPassword: string?

  @description('Optional. Specifies whether password authentication should be disabled.')
  disablePasswordAuthentication: bool?

  @description('Optional.List of SSH public keys to authenticate with the VM.')
  publicKeys: SSHKeyType?

  @description('Optional. Specifies whether the VM Agent should be provisioned.')
  provisionVMAgent: bool?

  @description('Optional. Configuration for automatic patching.')
  patchSettings: {
    @description('Required. Specifies whether the automatic Linux patching is enabled.')
    patchMode: 'Manual' | 'Automatic'

    @description('Optional. Specifies the patch assessment mode.')
    assessmentMode: 'AutomaticByPlatform' | 'ImageDefault'

    @description('Optional. Bypass platform safety checks on user schedule.')
    bypassPlatformSafetyChecksOnUserSchedule: bool?

    @description('Optional. Specifies the reboot setting for patching.')
    rebootSetting: 'Always' | 'IfRequired' | 'Never' | 'Unknown'
  }?
}

// Virtual Machine: OS disk
@export()
@description('The type describing an OS disk.')
type osDiskType = {
  @description('Optional. The disk name.')
  name: string?

  @description('Optional. Specifies the size of an empty data disk in gigabytes.')
  diskSizeGB: int?

  @description('Optional. Specifies how the virtual machine should be created.')
  createOption: 'Attach' | 'Empty' | 'FromImage'?

  @description('Optional. Specifies whether data disk should be deleted or detached upon VM deletion.')
  deleteOption: 'Delete' | 'Detach'?

  @description('Optional. Specifies the caching requirements.')
  caching: 'None' | 'ReadOnly' | 'ReadWrite'?

  @description('Optional. Specifies the ephemeral Disk Settings for the operating system disk.')
  diffDiskSettings: {
    @description('Required. Specifies the ephemeral disk placement for the operating system disk.')
    placement: ('CacheDisk' | 'NvmeDisk' | 'ResourceDisk')
  }?

  @description('Required. The managed disk parameters.')
  managedDisk: {
    @description('Optional. Specifies the storage account type for the managed disk.')
    storageAccountType:
      | 'PremiumV2_LRS'
      | 'Premium_LRS'
      | 'Premium_ZRS'
      | 'StandardSSD_LRS'
      | 'StandardSSD_ZRS'
      | 'Standard_LRS'
      | 'UltraSSD_LRS'?

    @description('Optional. Specifies the customer managed disk encryption set resource id for the managed disk.')
    diskEncryptionSetResourceId: string?

    @description('Optional. Specifies the resource id of a pre-existing managed disk. If the disk should be created, this property should be empty.')
    resourceId: string?
  }
}

// Virtual Machine: Data disk
@export()
@description('The type describing a data disk.')
type dataDiskType = {
  @description('Optional. The disk name. When attaching a pre-existing disk, this name is ignored and the name of the existing disk is used.')
  name: string?

  @description('Optional. Specifies the logical unit number of the data disk.')
  lun: int?

  @description('Optional. Specifies the size of an empty data disk in gigabytes. This property is ignored when attaching a pre-existing disk.')
  diskSizeGB: int?

  @description('Optional. Specifies how the virtual machine should be created. This property is automatically set to \'Attach\' when attaching a pre-existing disk.')
  createOption: 'Attach' | 'Empty' | 'FromImage'?

  @description('Optional. Specifies whether data disk should be deleted or detached upon VM deletion. This property is automatically set to \'Detach\' when attaching a pre-existing disk.')
  deleteOption: 'Delete' | 'Detach'?

  @description('Optional. Specifies the caching requirements. This property is automatically set to \'None\' when attaching a pre-existing disk.')
  caching: 'None' | 'ReadOnly' | 'ReadWrite'?

  @description('Optional. The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes. Ignored when attaching a pre-existing disk.')
  diskIOPSReadWrite: int?

  @description('Optional. The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. Ignored when attaching a pre-existing disk.')
  diskMBpsReadWrite: int?

  @description('Required. The managed disk parameters.')
  managedDisk: {
    @description('Optional. Specifies the storage account type for the managed disk. Ignored when attaching a pre-existing disk.')
    storageAccountType:
      | 'PremiumV2_LRS'
      | 'Premium_LRS'
      | 'Premium_ZRS'
      | 'StandardSSD_LRS'
      | 'StandardSSD_ZRS'
      | 'Standard_LRS'
      | 'UltraSSD_LRS'?

    @description('Optional. Specifies the customer managed disk encryption set resource id for the managed disk.')
    diskEncryptionSetResourceId: string?

    @description('Optional. Specifies the resource id of a pre-existing managed disk. If the disk should be created, this property should be empty.')
    resourceId: string?
  }

  @description('Optional. The tags of the public IP address. Valid only when creating a new managed disk.')
  tags: resourceInput<'Microsoft.Compute/disks@2025-01-02'>.tags?
}

// Virtual Machine: Extension: Auto-shutdown config
@export()
@description('The type describing the configuration profile.')
type autoShutDownConfigType = {
  @description('Optional. The status of the auto shutdown configuration.')
  status: 'Enabled' | 'Disabled'?

  @description('Optional. The time zone ID (e.g. China Standard Time, Greenland Standard Time, Pacific Standard time, etc.).')
  timeZone: string?

  @description('Optional. The time of day the schedule will occur.')
  dailyRecurrenceTime: string?

  @description('Optional. The resource ID of the schedule.')
  notificationSettings: {
    @description('Optional. The status of the notification settings.')
    status: 'Enabled' | 'Disabled'?

    @description('Optional. The email address to send notifications to (can be a list of semi-colon separated email addresses).')
    emailRecipient: string?

    @description('Optional. The locale to use when sending a notification (fallback for unsupported languages is EN).')
    notificationLocale: string?

    @description('Optional. The webhook URL to which the notification will be sent.')
    webhookUrl: string?

    @description('Optional. The time in minutes before shutdown to send notifications.')
    timeInMinutes: int?
  }?
}

// Virtual Machine: Extension: Entra ID SSH login
@export()
@description('Optional. "AADSSHLogin" configuration. ')
type aadSshExtensionConfigType = {
  @description('Required. Enabling extension for the virtual machine.')
  enabled: bool 
}

// Virtual Machine: Extension: Certificates from Key Vault
@export()
@description('The type describing the set of certificates that should be installed onto the virtual machine.')
type vaultSecretGroupType = {
  @description('Optional. The relative URL of the Key Vault containing all of the certificates in VaultCertificates.')
  sourceVault: subResourceType?

  @description('Optional. The list of key vault references in SourceVault which contain certificates.')
  vaultCertificates: {
    @description('Optional. For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name <UppercaseThumbprint>.crt for the X509 certificate file and <UppercaseThumbprint>.prv for private key. Both of these files are .pem formatted.')
    certificateStore: string?

    @description('Optional. This is the URL of a certificate that has been uploaded to Key Vault as a secret.')
    certificateUrl: string?
  }[]?
}

// SSH Key (Public Key)
@export()
@description('SSH Public Key type')
type SSHKeyType = {
  @description('Required. Path where the public key is stored.')
  path: string

  @description('Required. The public key data.')
  keyData: string
}[]?

