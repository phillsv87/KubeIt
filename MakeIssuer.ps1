param(
    [switch]$prod,
    [switch]$wild,
    [string]$namespace="letsencrypt"
)

$ErrorActionPreference="Stop"

if($prod){
    $server='https://acme-v02.api.letsencrypt.org/directory'
    $type='letsencrypt-prod'
}else{
    $server='https://acme-staging-v02.api.letsencrypt.org/directory'
    $type='letsencrypt-staging'
}

$tmpl=''
if($wild){
    $tmpl='cluster-issuer-acme'
}else{
    $tmpl='cluster-issuer'
}

&"$PSScriptRoot/TextTemplate.ps1" -out "$PSScriptRoot/../$($tmpl).yml" -tmpl $tmpl -server $server -type $type -namespace $namespace