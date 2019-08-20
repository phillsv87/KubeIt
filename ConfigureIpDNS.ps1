param(
    [string]$dnsName=$(throw "-dnsName required"),
    [string]$ip=$(throw "-ip required")
)

$PUBLICIPID=az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$ip')].[id]" --output tsv

Write-Host "IpId = $PUBLICIPID"

az network public-ip update --ids $PUBLICIPID --dns-name $dnsName
if(!$?){
    throw "Configure IP DNS Failed"
}