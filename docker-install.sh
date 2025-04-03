# This script installs Docker and Docker Compose on a Raspberry Pi running Raspberry Pi OS (Raspbian).

# Install Docker using the official convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add your user to the 'docker' group to run docker commands without sudo
sudo usermod -aG docker $USER


# Activate the group change:
newgrp docker

# Install the Docker Compose Plugin (V2)
sudo apt update
sudo apt install docker-compose-plugin -y