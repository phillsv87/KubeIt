# How to setup ingress


## Create Ingress Controller

1. Create a static IP using CreateIP.ps1 and add the IP to your config file using the publicIP key.
```
./CreateIP.ps1
# Add the generated IP to the local config using the publicIP key
# "publicIP":"x.x.x.x"
```

2. [Helm and Tiller Setup](./HelmSetup.md)

3. Create ingress Controller
```
./CreateIngressController.ps1
```
4. Wait for ingress controller to intialize

5. Configure DNS for public IP
```
./ConfigureIngressDNS.ps1
```
6. Either goto "Setup Cert Manager" of "Use existing Cert"


## Setup Cert Manager
Use free SSL certificates issued by Lets Encrypt. Use the -prod flag to generate a production certificate

1. Create Cert Manager
```
./CreateCertManager.ps1
```
2. Create Issuer
```
./CreateIssuer.ps1 -prod
```

3. Create Certificate
```
./MakeCert.ps1 -prod -domain exampledomain.com
kubectl apply -f ../cert.yml
```

4. Repeat step 3 for additional domains

## Use existing Cert
Use a certificate issued by a CA such as GoDaddy


## Create Ingress Route

1. Create default API route
```
./MakeIgressRoute.ps1 -prod `
    -serviceName exService `
    -servicePort 80 `
    -domain example.com

kubectl apply -f ../exService-ingress-route.yml
```