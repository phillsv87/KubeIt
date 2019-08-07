$config=Get-Content "$PSScriptRoot/config.json" | ConvertFrom-json

az aks get-credentials --resource-group $config.resGroup --name $config.clusterName