param(
    [string]$dnsName
)

$config=&$PSScriptRoot/GetConfig.ps1

if(!$dnsName){
    $dnsName="$($config.baseName)-ingress"
}
if(!$dnsName){
    throw "-dnsName required"
}

$ip=$config.publicIP
if(!$ip){
    throw "config.publicIP or -ip required"
}

&$PSScriptRoot/ConfigureIpDNS.ps1 -dnsName $dnsName -ip $ip