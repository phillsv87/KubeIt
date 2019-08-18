$config=&$PSScriptRoot/GetConfig.ps1
az acr show --name $config.acrName --resource-group $config.resGroup --query "id" --output tsv