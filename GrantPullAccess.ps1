$config=&$PSScriptRoot/GetConfig.ps1

$AKS_RESOURCE_GROUP=$config.resGroup
$AKS_CLUSTER_NAME=$config.clusterName
$ACR_RESOURCE_GROUP=$config.resGroup
$ACR_NAME=$config.acrName

"AKS_RESOURCE_GROUP = $AKS_RESOURCE_GROUP"
"AKS_CLUSTER_NAME = $AKS_CLUSTER_NAME"
"ACR_RESOURCE_GROUP = $ACR_RESOURCE_GROUP"
"ACR_NAME = $ACR_NAME"

# Get the id of the service principal configured for AKS
$CLIENT_ID=az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv

"CLIENT_ID = $CLIENT_ID"

# Get the ACR registry resource id
$ACR_ID=az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv

"ACR_ID = $ACR_ID"

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID