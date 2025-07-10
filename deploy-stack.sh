#!/bin/bash
# Deploy NVIDIA Stack

# Install NIM
nim auth login --api-key $NGC_API_KEY
nim cluster register --name gh200-genesis --gpu-type gh200

# Deploy core microservices
nim deploy --name genesis-codegen \
  --model nvidia/nemo/codellama-70b \
  --gpu-type gh200 \
  --replicas 4

nim deploy --name genesis-knowledge \
  --model nvidia/nemo/nemotron-4-340b \
  --gpu-type gh200 \
  --replicas 2

# Deploy monitoring
helm install nvidia-dcgm nvidia/dcgm-exporter \
  --set "serviceMonitor.enabled=true"
