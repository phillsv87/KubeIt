param(
    [switch]$prod,
    [string]$domain=$(throw "-domain required"),
    [string]$name=$(throw "-name required")
)


if($prod){
    $type='letsencrypt-prod'
}else{
    $type='letsencrypt-staging'
}

& $PSScriptRoot/TextTemplate.ps1 -tmpl cert -out "$PSScriptRoot/../cert-$($domain).yml" -domain $domain -type $type -name $name