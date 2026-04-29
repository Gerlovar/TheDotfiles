#!/bin/bash

# Configuración
DAY_DIR="$HOME/Pictures/Wallpapers/day"
NIGHT_DIR="$HOME/Pictures/Wallpapers/night"
INTERVAL=1800 # Tiempo en segundos (1800s = 30 minutos)

# Horas límite (Formato 24h)
DAY_START=0630   # 6:30 AM (siempre usar 4 dígitos)
NIGHT_START=1800 # 6:00 PM

LAST_WALLPAPER=""

while true; do
    HORA=$(date +%H%M)

    if [ "$HORA" -ge "$DAY_START" ] && [ "$HORA" -lt "$NIGHT_START" ]; then
        SELECTED_DIR="$DAY_DIR"
    else
        SELECTED_DIR="$NIGHT_DIR"
    fi

    COUNT=$(ls -1 "$SELECTED_DIR" | wc -l)

    if [ "$COUNT" -gt 1 ]; then
        # Bucle para no repetir
        while true; do
            WALLPAPER=$(ls "$SELECTED_DIR" | shuf -n 1)
            [ "$WALLPAPER" != "$LAST_WALLPAPER" ] && break
        done
    else
        # Si solo hay uno, pues elegimos ese y ya
        WALLPAPER=$(ls "$SELECTED_DIR" | head -n 1)
    fi

    LAST_WALLPAPER="$WALLPAPER"

    # Aplicar con awww (con efecto suave)
    awww img "$SELECTED_DIR/$WALLPAPER" --transition-type outer --transition-pos 0.85,0.85 --transition-step 60
    matugen image "$SELECTED_DIR/$WALLPAPER" --source-color-index 0
    killall -SIGUSR2 waybar
    # Esperar hasta el próximo cambio
    sleep $INTERVAL
done
