#!/bin/bash

# Обновление системы и установка необходимых пакетов
echo "Обновление системы и установка необходимых пакетов..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git jq build-essential gcc unzip wget lz4 docker.io docker-compose

# Проверка установки Docker и Docker Compose
echo "Проверка установки Docker и Docker Compose..."
docker --version
docker-compose --version

# Создание папки для узла Ocean
echo "Создание папки для узла Ocean..."
mkdir -p ~/ocean && cd ~/ocean

# Загрузка и запуск скрипта Ocean Node
echo "Загрузка и запуск скрипта установки Ocean Node..."
curl -O https://raw.githubusercontent.com/oceanprotocol/ocean-node/main/scripts/ocean-node-quickstart.sh
chmod +x ocean-node-quickstart.sh
./ocean-node-quickstart.sh

# Ввод данных для запуска узла
echo "Генерация приватного ключа и ввод данных для узла Ocean..."
read -p "Do you have your private key for running the Ocean Node [ y/n ]: " key_answer
if [[ "$key_answer" == "n" ]]; then
    echo "y" | ./ocean-node-quickstart.sh
    echo "Приватный ключ сгенерирован."
else
    echo "n" | ./ocean-node-quickstart.sh
fi

# Ввод сгенерированного ключа и кошелька
echo "Введите сгенерированный приватный ключ и кошелек для узла Ocean:"
read -p "Приватный ключ: " private_key
read -p "Адрес кошелька (import key to MetaMask): " wallet_address

# Настройка портов
read -p "Provide the HTTP_API_PORT value or accept the default (press Enter) [8000]: " http_port
http_port=${http_port:-8000}

read -p "Provide the P2P_ipV4BindTcpPort or accept the default (press Enter) [9000]: " ipv4_port
ipv4_port=${ipv4_port:-9000}

read -p "Provide the P2P_ipV4BindWsPort or accept the default (press Enter) [9001]: " ws_ipv4_port
ws_ipv4_port=${ws_ipv4_port:-9001}

read -p "Provide the P2P_ipV6BindTcpPort or accept the default (press Enter) [9002]: " ipv6_port
ipv6_port=${ipv6_port:-9002}

read -p "Provide the P2P_ipV6BindWsPort or accept the default (press Enter) [9003]: " ws_ipv6_port
ws_ipv6_port=${ws_ipv6_port:-9003}

read -p "Provide the public IPv4/IPv6 address or FQDN where this node will be accessible: " node_ip

# Создание Docker Compose файла и запуск узла
echo "Запуск узла Ocean с Docker Compose..."
docker-compose up -d

# Настройка брандмауэра
echo "Настройка брандмауэра для входящих TCP-портов..."
sudo ufw allow $http_port/tcp
sudo ufw allow $ipv4_port/tcp
sudo ufw allow $ws_ipv4_port/tcp
sudo ufw allow $ipv6_port/tcp
sudo ufw allow $ws_ipv6_port/tcp

# Проверка логов
echo "Проверка логов Docker..."
docker-compose logs -f
