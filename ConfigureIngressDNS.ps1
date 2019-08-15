param(
    [string]$dnsName
)

if(!$dnsName){
    throw "-dnsName required"
}

$config=&$PSScriptRoot/GetConfig.ps1

if(!$config.publicIP){
    throw "config.publicIP required"
}

$IP=$config.publicIP

$PUBLICIPID=az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv

Write-Host "IpId = $PUBLICIPID"

az network public-ip update --ids $PUBLICIPID --dns-name $dnsName