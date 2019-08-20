param(
    [string]$name=$(throw "-name required"),
    [string]$sku="Standard_LRS"
)

#skus Standard_LRS,Standard_GRS,Standard_RAGRS,Standard_ZRS,Premium_LRS,Premium_ZRS,Standard_GZRS,Standard_RAGZRS

$config=&$PSScriptRoot/GetConfig.ps1


$AKS_PERS_STORAGE_ACCOUNT_NAME="$($name)storage"
$AKS_PERS_RESOURCE_GROUP=$config.clusterResGroup
$AKS_PERS_LOCATION=$config.location
$AKS_PERS_SHARE_NAME="$($name)share"


# Create a storage account
az storage account create -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -l $AKS_PERS_LOCATION --sku $sku
if(!$?){
    throw "Create storage account failed"
}

# Export the connection string as an environment variable, this is used when creating the Azure file share
$AZURE_STORAGE_CONNECTION_STRING=az storage account show-connection-string -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -o tsv
if(!$?){
    throw "Get storage connection string failed"
}

# Create the file share
az storage share create -n $AKS_PERS_SHARE_NAME --connection-string $AZURE_STORAGE_CONNECTION_STRING
if(!$?){
    throw "Create file share failed"
}

# Get storage account key
$STORAGE_KEY=az storage account keys list --resource-group $AKS_PERS_RESOURCE_GROUP --account-name $AKS_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv
if(!$?){
    throw "Get storage account key failed"
}

# Echo storage account name and key
Write-Host "Storage account name: $AKS_PERS_STORAGE_ACCOUNT_NAME"
Write-Host "Storage account key: $STORAGE_KEY"