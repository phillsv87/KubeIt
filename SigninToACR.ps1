$config=&$PSScriptRoot/GetConfig.ps1

if(!$config.acrName){
    throw "config.acrName required"
}

az acr login --name $config.acrName
if(!$?){
    throw "ACR login failed"
}