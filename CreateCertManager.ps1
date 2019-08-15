$ErrorActionPreference="Stop"

# Install the CustomResourceDefinition resources separately
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml
if(!$?){throw "00-crds.yml apply failed"}

# Create the namespace for cert-manager
kubectl create namespace cert-manager
if(!$?){throw "create cert-manager namespace failed"}

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
if(!$?){throw "disabled resource validation failed"}

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io
if(!$?){throw "add jetstack repo failed"}

# Update your local Helm chart repository cache
helm repo update
if(!$?){throw "helm update failed"}

# Install the cert-manager Helm chart
helm install `
  --name cert-manager `
  --namespace cert-manager `
  --version v0.8.0 `
  jetstack/cert-manager
if(!$?){throw "Install jetstack/cert-manager chart failed"}