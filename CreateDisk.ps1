param (
    [string]$name,
    [int]$sizeGB,
    [string]$sku="Standard_LRS",
    [string]$location
)

#Sku types: Standard_LRS,Premium_LRS,StandardSSD_LRS,UltraSSD_LRS

if(!$name -or !$sizeGB){
    throw "name and sizeGB required"
}

$config=&$PSScriptRoot/GetConfig.ps1

if(!$location){
    $location=$config.location
}

az disk create `
  --resource-group $config.clusterResGroup `
  --name $name `
  --size-gb $sizeGB `
  --sku $sku `
  --location $location `
  --query id --output tsv