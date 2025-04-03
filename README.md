# Minecraft server using docker
## Pre-requisites:
### Raspberry Pi:
A Raspberry Pi 3B+ or preferably a Raspberry Pi 4 (with 4GB or 8GB RAM recommended for better performance) running Raspberry Pi OS (or another compatible Linux distribution).

### Raspberry Pi OS Updated:
Ensure your system is up-to-date:

```bash
sudo apt update
sudo apt upgrade -y
```

## Steps
### Install Docker and Docker Compose
#### Via bash script (need testing)

```bash
./docker-install.sh
```

#### Via command line

```bash
# Install Docker using the official convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add your user to the 'docker' group to run docker commands without sudo
sudo usermod -aG docker $USER

# Activate the group change:
newgrp docker

# Install the Docker Compose Plugin (V2)
sudo apt install docker-compose-plugin -y

# Verify installations
docker --version
docker compose version
```

### Start the Minecraft server
```bash
cd server
docker compose up -d
```

### Monitor the server (Optional)
```bash
docker compose logs -f
```

### Connect to Your Server
#### From your Local Network:
1. Find your Raspberry Pi's local IP address. Run `ip addr show` or `hostname -I` on the Pi. Look for an address like `192.168.1.XXX` or `10.0.0.XXX`.
2. Open Minecraft Java Edition on a computer on the same network.
3. Go to `Multiplayer -> Add Server`.
4. Enter a server name (e.g., "My Pi Server").
5. For the Server Address, enter the Raspberry Pi's local IP address (e.g., `192.168.1.100`). You usually don't need to add the port `:25565` if it's the default, but you can include it (`192.168.1.100:25565`).
6. Click `Done` and try to connect!

#### Allowing Friends to Connect (Internet): TODO (@exnalto)

### Important Considerations

#### Performance
A Raspberry Pi has limited resources. Don't expect it to handle dozens of players or heavy modpacks. Keep the player count low (e.g., 2-5 friends) and avoid resource-intensive mods/plugins. Using PaperMC (`TYPE=PAPER`) helps significantly. Monitor CPU and RAM usage (`htop` is a good tool). Adjust the `MEMORY` setting in `docker-compose.yml` if needed (you'll need to stop and restart the server after changing it).

#### SD Card Wear
Running a server involves constant reads/writes, which can wear out SD cards over time. Consider using a high-endurance SD card or, even better, booting/running from an external USB SSD.

#### Public IP Changes
Most residential internet connections have dynamic IP addresses, meaning your public IP can change. If it does, you'll need to give your friends the new one. Look into Dynamic DNS (DDNS) services (like No-IP or DuckDNS) for a more permanent solution if this becomes annoying.

#### Security
Opening a port to the internet has security implications. Keep your Raspberry Pi OS and Docker updated. Use a strong password for your Pi. Consider enabling the server whitelist (`ENFORCE_WHITELIST: "TRUE"` and `WHITELIST: "Player1,Player2"` in `docker-compose.yml`) so only approved players can join.

#### Backups
Regularly back up the `./minecraft-data` directory! This contains your world and server settings.

### Managing the Server

#### Stop the Server
```bash
cd ~/minecraft-server && docker compose down
```

#### Start the Server
```bash
cd ~/minecraft-server && docker compose up -d
```

#### Restart the Server
```bash
cd ~/minecraft-server && docker compose restart
```

#### Update Minecraft (if using `VERSION: LATEST`)
```bash
cd ~/minecraft-server
docker compose pull # Download the latest itzg/minecraft-server image
docker compose down # Stop the current server
docker compose up -d # Start with the new image
```

#### Access Server Console
```bash
docker attach mc-java-server
```
> Press `Ctrl+P` then `Ctrl+Q` to detach without stopping the server. You can run Minecraft server commands here.
