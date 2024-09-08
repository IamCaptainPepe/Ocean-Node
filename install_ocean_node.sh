#!/bin/bash

# Шаг 1: Обновление системы и установка необходимых пакетов
echo "Обновление системы и установка необходимых пакетов..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git jq build-essential gcc unzip wget lz4 docker.io docker-compose

# Проверка установки Docker и Docker Compose
echo "Проверка установки Docker и Docker Compose..."
docker --version
docker-compose --version

# Шаг 2: Создание папки для узла Ocean
echo "Создание папки для узла Ocean..."
mkdir -p ~/ocean && cd ~/ocean

# Шаг 3: Загрузка и запуск скрипта Ocean Node
echo "Загрузка и запуск скрипта установки Ocean Node..."
curl -O https://raw.githubusercontent.com/oceanprotocol/ocean-node/main/scripts/ocean-node-quickstart.sh
chmod +x ocean-node-quickstart.sh
./ocean-node-quickstart.sh


# Запуск Docker Compose
echo "Запуск узла Ocean..."
docker-compose up -d


# Шаг 4: Проверка логов
echo "Проверка логов Docker..."
docker-compose logs -f
