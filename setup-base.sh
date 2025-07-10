#!/bin/bash
# Base Setup for GH200 Nodes

# Install NVIDIA Brev
curl -fsSL https://brev.nvidia.com/install.sh | sh
brev init --runtime gh200-full

# Install core dependencies
sudo apt update && sudo apt install -y \
  docker-compose \
  kubectl \
  helm \
  nvidia-docker2

# Configure Docker for NVIDIA
sudo tee /etc/docker/daemon.json <<EOF
{
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "default-runtime": "nvidia"
}
EOF
sudo systemctl restart docker

# Pull core images
docker pull nvcr.io/nvidia/nemo:24.05
docker pull nvcr.io/nvidia/nemo-agent-toolkit:24.05
docker pull nvcr.io/nvidia/nemo-rl:24.05
