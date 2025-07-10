#!/bin/bash
# NeuroGenesis MCP Deployment for NVIDIA GH200
# Version 1.0 - 25.06.2025

set -e

# Configuration
export CLUSTER_NAME="genesis-cluster"
export NGC_API_KEY="your_ngc_api_key"
export LAMBDA_API_KEY="your_lambda_api_key"
export SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"

# Step 1: Create GH200 Cluster
echo "🚀 Creating GH200 cluster on Lambda Cloud..."
lambda instances create \
  --region us-east-1 \
  --instance-type gh200.120gb.1x \
  --quantity 8 \
  --name $CLUSTER_NAME \
  --ssh-key-path $SSH_KEY_PATH

# Retrieve master node IP
MASTER_IP=$(lambda instances list --name $CLUSTER_NAME | grep master | awk '{print $5}')
echo "🔧 Master node IP: $MASTER_IP"

# Step 2: Prepare Base System
echo "🛠️ Preparing master node..."
scp -o StrictHostKeyChecking=no -r ./neurogenesis-gh200 ubuntu@$MASTER_IP:~
ssh ubuntu@$MASTER_IP "cd neurogenesis-gh200 && chmod +x *.sh && ./setup-base.sh"

# Step 3: Deploy Core Services
echo "⚙️ Deploying NVIDIA stack..."
ssh ubuntu@$MASTER_IP "cd neurogenesis-gh200 && ./deploy-stack.sh"

# Step 4: Initialize Genesis OS
echo "🌐 Initializing GENESIS OS knowledge base..."
ssh ubuntu@$MASTER_IP "cd neurogenesis-gh200 && ./init-genesis.sh"

echo "✅ Deployment complete! Access dashboard: http://$MASTER_IP:3000"
