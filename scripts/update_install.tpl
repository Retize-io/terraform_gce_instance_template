#!/bin/bash
REGION=${region}
echo "Atualizando repositórios"
sudo apt-get -y install
sudo apt-get update
sudo apt-get upgrade -y

echo "Instalando Docker e outras dependências"
curl -fsSL https://get.docker.com -o get-docker.sh
yes | sudo sh get-docker.sh

echo "Instalando o ops agent"
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

yes | gcloud auth configure-docker $REGION-docker.pkg.dev 
sudo docker container prune -f
sudo docker image prune -f
