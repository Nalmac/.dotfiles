#!/bin/bash

# Vérifier si le fichier et le nouveau thème sont fournis
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_settings.ini> <new_theme>"
    exit 1
fi

SETTINGS_FILE=$1
NEW_THEME=$2

# Vérifier si le fichier existe
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "Error: File $SETTINGS_FILE not found."
    exit 1
fi

# Utiliser sed pour remplacer la clé gtk-theme-name
sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$NEW_THEME/" "$SETTINGS_FILE"

echo "Updated gtk-theme-name to $NEW_THEME in $SETTINGS_FILE"

