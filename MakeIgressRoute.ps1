param(
    [switch]$prod,
    [string]$serviceName=$(throw "-serviceName required"),
    [int]$servicePort=$(throw "-servicePort required"),
    [string]$domain=$(throw "-domain required")
)

if($prod){
    $type='letsencrypt-prod'
}else{
    $type='letsencrypt-staging'
}

& $PSScriptRoot/TextTemplate.ps1 -tmpl ingress-route `
    -type $type `
    -serviceName $serviceName `
    -servicePort $servicePort `
    -domain $domain `
    -out "$PSScriptRoot/../$($serviceName)-ingress-route.yml"