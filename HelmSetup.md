## How to setup Helm

1. Install helm on local machine - https://github.com/helm/helm/releases
2. Create Tiller service account 
```
kubectl apply -f helm-rbac.yml
```
3. Install tiller in cluster
```
helm init --service-account tiller --node-selectors "beta.kubernetes.io/os=linux"
```
4. Test tiller install. If heml list does not display an error tiller installed.
```
helm list
```