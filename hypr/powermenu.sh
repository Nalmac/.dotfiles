#!/bin/bash

# Vérifier si wofi est installé
if ! command -v wofi &> /dev/null; then
    echo "wofi n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

# Options du menu
options=("󰐥 Éteindre" "󰍃 Déconnexion" " Verrouillage" "󰜉 Redémarrer")

# Afficher le menu avec wofi
choice=$(printf '%s\n' "${options[@]}" | wofi -n --dmenu --cache-file /dev/null -p "Action désirée")
text_choice=$(echo "$choice" | cut -c 2- | xargs)


case $choice in
    "󰐥 Éteindre")
        systemctl poweroff
        ;;
    "󰍃 Déconnexion")
	    loginctl terminate-user $USER
        ;;
    " Verrouillage")
       
	gtklock
        ;;
    "󰜉 Redémarrer")
        systemctl reboot
        ;;
    *)
        echo "Option invalide"
        ;;
esac

