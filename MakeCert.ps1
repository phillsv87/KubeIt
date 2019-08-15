param(
    [switch]$prod,
    [string]$domain=$(throw "-domain required")
)


if($prod){
    $type='letsencrypt-prod'
}else{
    $type='letsencrypt-staging'
}

& $PSScriptRoot/TextTemplate.ps1 -tmpl cert -outParent -domain $domain -type $type