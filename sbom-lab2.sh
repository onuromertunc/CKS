#!/usr/bin/env bash
# SBOM pratik scripti (default namespace, sade sürüm)
# - bom v0.6.0 kurar
# - default namespace'e Deployment uygular
# - sonunda görev metnini ekrana yazar

set -euo pipefail

# ---- bom kurulumu ----
VERSION=v0.6.0
echo ">> bom ${VERSION} indiriliyor ve kuruluyor..."
curl -fsSL "https://github.com/kubernetes-sigs/bom/releases/download/${VERSION}/bom-amd64-linux" -o bom
sudo mv bom /usr/local/bin/bom
sudo chmod +x /usr/local/bin/bom
echo ">> bom kuruldu."

# ---- Deployment uygulanıyor ----
echo ">> Deployment uygulanıyor (namespace=default)..."
cat <<'YAML' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: libcrypto3
  labels:
    app: libcrypto3
spec:
  replicas: 1
  selector:
    matchLabels:
      app: libcrypto3
  template:
    metadata:
      labels:
        app: libcrypto3
    spec:
      containers:
        - name: alpine-320
          image: alpine:3.20.0
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
        - name: alpine-319
          image: alpine:3.19.6
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
        - name: alpine-316
          image: alpine:3.16.1
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
YAML

# ---- Görev metni ----
echo
echo "========== SBOM PRACTICE TASK =========="
echo "Find libcrypto3 package"
echo "========================================"

# ---- Deployment çıktısı ----
echo
kubectl get deployments
