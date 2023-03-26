#!/bin/sh

# usage: import-gsettings
config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

# Color scheme for GTK apps can be 0 (light, default) and 1 (dark)
color_scheme="$(grep 'gtk-application-prefer-dark-theme' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
gnome_schema="org.gnome.desktop.interface"
gnome_wm_schema="org.gnome.desktop.wm.preferences"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"

gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" font-name "$font_name"
gsettings set "$gnome_wm_schema" button-layout ""

if [ "$color_scheme" -eq 1 ]; then
	gsettings set "$gnome_schema" color-scheme "prefer-dark"
else
	gsettings set "$gnome_schema" color-scheme "prefer-light"
fi
