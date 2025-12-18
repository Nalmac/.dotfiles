#!/bin/bash
WALLPAPER_DIR="$HOME/wallpapers/walls"
#I dont know what the fuck I am doing
menu() {
  find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}
main() {
  choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
  selected_wallpaper=$(echo "$choice" | sed 's/^img://')
  swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
  wal -i "$selected_wallpaper" -n --cols16
  swaync-client --reload-css
  cat ~/.cache/wal/colors-kitty.conf >~/.config/kitty/current-theme.conf
  pywalfox update
  color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
  color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
  cava_config="$HOME/.config/cava/config"
  sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" $cava_config
  sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" $cava_config
  pkill -USR2 cava 2>/dev/null
  source ~/.cache/wal/colors.sh && cp -r $wallpaper ~/wallpapers/pywallpaper.jpg
  cp ~/.cache/wal/colors-zed.json ~/.config/zed/themes/pywal-zed.json
  notify-send "Theming Agent" "Fond d'écran changé avec succès, création de l'écran de verrouillage"
  rm ~/wallpapers/lockscreen.jpg
  magick ~/wallpapers/pywallpaper.jpg -blur 0x8 ~/wallpapers/lockscreen.jpg
  rm /usr/share/backgrounds/lockscreen.jpg
  cp ~/wallpapers/lockscreen.jpg /usr/share/backgrounds/lockscreen.jpg
  notify-send "Theming Agent" "Écran de verrouillage créé sans encombre, on passe au thème GTK"
  rm -rf $HOME/.themes/pywal_gtk
  oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse --output pywal_gtk
  notify-send "Theming Agent" "Thème GTK remplacé, on fait la magie pour Obsidian"
  OBSIDIAN_JSON="$HOME/Documents/OBSIDIAN/brain2/.obsidian/appearance.json"
  jq --arg new_color "$color1" '.accentColor = $new_color' "$OBSIDIAN_JSON" >tmp.json && mv tmp.json "$OBSIDIAN_JSON"
  notify-send "Theming Agent" "Obsidian adapté, finissons par les icônes..."
  rm -rf $HOME/.icons/pywal_icons
  /opt/oomox/plugins/icons_numix/change_color.sh --output pywal_icons /opt/oomox/scripted_colors/xresources/xresources-reverse
  notify-send "Theming Agent" "Finex !"
}
main
