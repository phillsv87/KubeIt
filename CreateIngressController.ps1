$config=Get-Content "$PSScriptRoot/config.json" | ConvertFrom-json

if(!$config.publicIP){
    throw "config.publicIP required"
}

helm install stable/nginx-ingress `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set controller.service.loadBalancerIP="$($config.publicIP)"