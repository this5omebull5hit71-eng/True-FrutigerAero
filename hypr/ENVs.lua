----------------------------------------------------------------------------------------
-- VARIABLES DE ENTORNO (ENVs) - TRUE-FRUTIGER-GLASS (Lua)
----------------------------------------------------------------------------------------

-- 1. Especificaciones XDG (Para que el sistema sepa que estás en Hyprland)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- 2. Forzar el uso de Wayland en las aplicaciones (GTK, Qt, SDL)
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- 3. Configuración de Qt (Esencial para Dolphin y el tema de cristal con Kvantum)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") 
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- 4. Tamaño y renderizado del Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- 5. Forzar Wayland en navegadores (como Firefox o Chrome/Opera)
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("OZONE_PLATFORM", "wayland")
