param(
    $name
)

$config=&$PSScriptRoot/GetConfig.ps1

az acr create --resource-group $config.resGroup --name $name --sku Basic