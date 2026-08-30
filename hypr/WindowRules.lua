----------------------------------------------------------------------------------------
-- REGLAS DE VENTANAS Y WORKSPACES (TRUE-FRUTIGER-GLASS)
----------------------------------------------------------------------------------------

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

----------------------------------------------------------------------------------------
-- REGLAS DE CRISTAL / BLUR (KITTY & DOLPHIN)
----------------------------------------------------------------------------------------
hl.config({
    windowrulev2 = {
        -- Reglas para la terminal Kitty
        "blur, class:^(kitty)$",
        "ignorezero, class:^(kitty)$",
        
        -- Reglas para el gestor de archivos Dolphin (Blur + Opacidad de Cristal)
        "blur, class:^(org.kde.dolphin)$",
        "ignorezero, class:^(org.kde.dolphin)$",
        "opacity 0.80 0.70, class:^(org.kde.dolphin)$"
    }
})

------ Rofi ------

hl.config({
    layerrule = {
        "blur, rofi",
        "ignorezero, rofi"
    }
})


---------- Dunst ----------

hl.config({
    layerrule = {
        -- Reglas para Rofi (ya las tenías)
        "blur, rofi",
        "ignorezero, rofi",

        -- Reglas para Dunst
        "blur, dunst",
        "ignorezero, dunst"
    }
})
