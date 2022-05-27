#Set XDG_CURRENT_DESKTOP to Sway (for screencasting and screensharing capabilities)
export XDG_CURRENT_DESKTOP=sway

# Force Wayland for Mozilla Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export GTK_CSD=0

# Force Wayland for Qt apps
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt5ct

#Java XWayland blank screens fix
export _JAVA_AWT_WM_NONREPARENTING=1

#Check if system is running on Virtual Box

if [ $(systemd-detect-virt) = oracle ]; then
     echo "Running in VirtualBox. Disabling hardware cursors"
     export WLR_NO_HARDWARE_CURSORS=1
else
     echo "No VM is detected"
fi
