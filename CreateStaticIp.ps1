param(
    [string]$name
)

if(!$name){
    throw "-name required"
}

$config=Get-Content "$PSScriptRoot/config.json" | ConvertFrom-json

az network public-ip create `
    --resource-group $config.clusterResGroup `
    --name $name `
    --allocation-method static