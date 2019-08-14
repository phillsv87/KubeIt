param(
    [string]$name=$(throw '-name required')
)

kubectl create secret tls $name-ingress-tls `
   --key ./certs/$($name).key `
   --cert ./certs/$($name).crt