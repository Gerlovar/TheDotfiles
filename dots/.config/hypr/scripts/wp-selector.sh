#!/bin/bash

# Directorio de tus fondos de pantalla
DIR="$HOME/Pictures/Wallpapers"

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

# Listar archivos, quitando la ruta completa para que wofi solo muestre el nombre
SELECCION=$(ls "$DIR" | wofi --dmenu --prompt "Selecciona un fondo..." -c ~/.config/wofi/config.h)

# Si seleccionaste algo, aplicarlo
if [ -n "$SELECCION" ]; then
    awww img "$DIR/$SELECCION" --transition-type center --transition-step 100 --transition-fps 60
    #EJECUTAR MATUGEN
    matugen image "$DIR/$SELECCION" --source-color-index 0

    # 4. RECARGAR COMPONENTES (Opcional pero recomendado)
    # Algunos programas necesitan una señal para leer los nuevos colores
    killall -SIGUSR2 waybar # Recarga Waybar sin cerrarlo
    # hyprctl reload       # Si usas colores de matugen en bordes de Hyprland
fi
