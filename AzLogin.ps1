param(
    [switch]$skipCluster,
    [switch]$skipContainer
)
Write-Host "Signing in to Azure" -Foreground Yellow
az login
if(!$?){
    throw "Azure login failed"
}
Write-Host "Sign in to Azure success" -Foreground DarkGreen

if(!$skipCluster){
    Write-Host "Connecting to cluster" -Foreground Yellow
    &$PSScriptRoot/ConnectToCluster.ps1
    Write-Host "Connect to cluster success" -Foreground DarkGreen
}

if(!$skipContainer){
    Write-Host "Signing in to ACR" -Foreground Yellow
     &$PSScriptRoot/SigninToACR.ps1
     Write-Host "Sign in to ACR success" -Foreground DarkGreen
}


az account show