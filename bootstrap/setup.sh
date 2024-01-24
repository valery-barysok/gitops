# https://github.com/prometheus-operator/kube-prometheus/blob/main/README.md#minikube
# minikube config defaults kubernetes-version # list displays all valid default settings for kubernetes-version
minikube start -p gitops \
  --kubernetes-version=v1.28.3 \
  --memory 16384 \
  --cpus 4 \
  --addons=dashboard \
  --bootstrapper=kubeadm \
  --extra-config=kubelet.authentication-token-webhook=true \
  --extra-config=kubelet.authorization-mode=Webhook \
  --extra-config=scheduler.bind-address=0.0.0.0 \
  --extra-config=controller-manager.bind-address=0.0.0.0 \
  --extra-config=etcd.listen-metrics-urls=http://0.0.0.0:2381
minikube profile gitops

# export GITHUB_TOKEN=...
flux bootstrap github \
  --owner=valery-barysok \
  --repository=gitops \
  --branch=main \
  --path=clusters/infra \
  --private=false \
  --personal=true
