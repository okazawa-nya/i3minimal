#!/bin/sh

# Подгружаем цветовую схему терминала
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Запускаем оконный менеджер
exec i3
