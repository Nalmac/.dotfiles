#!/bin/bash

# Vérifier si wofi est installé
if ! command -v wofi &>/dev/null; then
  echo "wofi n'est pas installé. Veuillez l'installer d'abord."
  exit 1
fi

# Options du menu
options=("󰐥" "󰍃" "" "󰜉")

# Afficher le menu avec wofi
choice=$(printf '%s\n' "${options[@]}" | wofi -c ~/.config/wofi/power-menu -s ~/.config/wofi/style-power.css)
text_choice=$(echo "$choice" | cut -c 2- | xargs)

case $choice in
"󰐥")
  systemctl poweroff
  ;;
"󰍃")
  loginctl terminate-user $USER
  ;;
"")

  gtklock
  ;;
"󰜉")
  systemctl reboot
  ;;
*)
  echo "Option invalide"
  ;;
esac
