#!/bin/bash
set -e 


USERNAME="okazawa-nya"
REPO="i3minimal"
REPO_URL="https://raw.githubusercontent.com/$USERNAME/$REPO/main"

echo "=== Запуск автоматической настройки среды ==="

# 1. Скачивание списка пакетов
echo "[1/4] Загрузка списка программ..."
wget -qO packages.txt "$REPO_URL/packages.txt"

# 2. Установка зависимостей
echo "[2/4] Обновление apt и установка пакетов..."
sudo apt update
PACKAGES=$(grep -vE '^\s*#|^\s*$' packages.txt | tr '\n' ' ')
sudo apt install -y --no-install-recommends $PACKAGES

# 3. Создание структуры директорий
echo "[3/4] Создание системных папок..."
mkdir -p ~/.config/i3/wallpapers

# 4. Загрузка конфигурационных файлов
echo "[4/4] Загрузка конфигураций с GitHub..."
wget -qO ~/.config/i3/config "$REPO_URL/i3_config"
wget -qO ~/.config/i3/i3status.conf "$REPO_URL/i3status.conf"
wget -qO ~/.Xresources "$REPO_URL/.Xresources"
wget -qO ~/.xinitrc "$REPO_URL/.xinitrc"
wget -qO ~/.config/i3/wallpapers/default.jpg "$REPO_URL/wallpapers/default.jpg"

# Исправление прав доступа
sudo chown -R $USER:$USER ~/.config/i3 ~/.Xresources ~/.xinitrc

echo "=========================================="
echo "Установка завершена!"
echo "Запустите графическое окружение командой: startx"
echo "=========================================="
