param(
    $name
)

$config=Get-Content "$PSScriptRoot/config.json" | ConvertFrom-json

az acr create --resource-group $config.resGroup --name $name --sku Basic