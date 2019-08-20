param(
    [string]$name,
    [string]$key
)

$config=&$PSScriptRoot/GetConfig.ps1

if(!$name){
    $name=$config.storageAccountName
}

if(!$key){
    $key=$config.storageAccountKey
}

if(!$name){
    throw "-name required"
}

if(!$key){
    throw "-key required"
}

$AKS_PERS_STORAGE_ACCOUNT_NAME="$($name)"

kubectl create secret generic "$name-storage-secret" --from-literal=azurestorageaccountname=$AKS_PERS_STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$key
if(!$?){
    throw "Create secret failed"
}

Write-Host "Create secret $name-storage-secret for $AKS_PERS_STORAGE_ACCOUNT_NAME storage account"