param(
    [switch]$prod
)

$ErrorActionPreference="Stop"

if($prod){
    $server='https://acme-v02.api.letsencrypt.org/directory'
    $type='letsencrypt-prod'
}else{
    $server='https://acme-staging-v02.api.letsencrypt.org/directory'
    $type='letsencrypt-staging'
}

$yml=& $PSScriptRoot/TextTemplate.ps1 -tmp -tmpl cluster-issuer -server $server -type $type

kubectl apply -f $yml
if(!$?){throw "Apply cluster-issuer failed"}