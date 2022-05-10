  owner /run/user/[0-9]*/bus rw,
  dbus send
       bus=session
       path=/org/freedesktop/DBus
       interface=org.freedesktop.DBus
       member={Hello,RequestName}
       peer=(name=org.freedesktop.DBus),
  dbus (send)
       bus=session
       path=/org/freedesktop/Notifications
       interface=org.freedesktop.Notifications
       member=NotificationClosed,
  dbus (receive)
       bus=session
       path=/org/freedesktop/Notifications
       interface=org.freedesktop.Notifications
       member={Notify,NotificationClosed,GetServerInformation,GetCapabilities,CloseNotification},
