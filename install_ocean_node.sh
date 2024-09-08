#!/bin/bash

echo "Обновление системы и установка необходимых пакетов снова..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git jq build-essential gcc unzip wget lz4

# Шаг 1: Установка Docker
echo "Установка Docker..."
sudo apt install docker.io -y && \
docker --version

# Шаг 2: Установка Docker Compose
echo "Установка Docker Compose..."
sudo apt install docker-compose -y && \
docker-compose --version

# Шаг 3: Создание папки для узла Ocean
echo "Создание папки для узла Ocean..."
mkdir -p ~/ocean && cd ~/ocean

# Шаг 4: Загрузка и запуск скрипта Ocean Node
echo "Загрузка и запуск скрипта установки Ocean Node..."
curl -O https://raw.githubusercontent.com/oceanprotocol/ocean-node/main/scripts/ocean-node-quickstart.sh
chmod +x ocean-node-quickstart.sh
./ocean-node-quickstart.sh


# Запуск Docker Compose
echo "Запуск узла Ocean..."
docker-compose up -d


# Шаг 5: Проверка логов
echo "Проверка логов Docker..."
docker-compose logs -f
