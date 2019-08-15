$config=&$PSScriptRoot/GetConfig.ps1

az aks get-credentials --resource-group $config.resGroup --name $config.clusterName