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
  name: fruitlab
  labels:
    app: fruitlab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fruitlab
  template:
    metadata:
      labels:
        app: fruitlab
    spec:
      containers:
        - name: apple
          image: kodekloud/apple-image:v1
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
        - name: banana
          image: kodekloud/banana-image:v1
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
        - name: kiwi
          image: kodekloud/kiwi-image:v1
          imagePullPolicy: IfNotPresent
          command: ["sleep","7200"]
YAML

# ---- Görev metni ----
echo
echo "========== SBOM PRACTICE TASK =========="
echo "One of the containers has the package curl installed. Identify which container has that package, and create an SBOM SPDX for the container's image."
echo "========================================"

# ---- Deployment çıktısı ----
echo
kubectl get deployments
