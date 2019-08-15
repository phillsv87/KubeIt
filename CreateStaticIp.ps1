param(
    [string]$name
)

if(!$name){
    throw "-name required"
}

$config=&$PSScriptRoot/GetConfig.ps1

az network public-ip create `
    --resource-group $config.clusterResGroup `
    --name $name `
    --allocation-method static