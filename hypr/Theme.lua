----------------------------------------------------------------------------------------
-- TEMAS, COLORES Y APARIENCIA (LOOK AND FEEL - HYPRLAND)
----------------------------------------------------------------------------------------

hl.config({
    -- Configuración general del gestor de ventanas y bordes
    general = {
        gaps_in  = 5,    -- Espacio interno entre ventanas vecinas (en píxeles)
        gaps_out = 20,   -- Espacio externo entre las ventanas y los bordes de la pantalla

        border_size = 2, -- Grosor del borde de las ventanas (en píxeles)

        col = {
            -- Borde activo: degradado de azul claro a verde menta en ángulo de 45°
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            -- Borde inactivo: gris semitransparente para ventanas sin foco
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false, -- Desactiva redimensionar ventanas arrastrando sus bordes
        allow_tearing    = false, -- Desactiva el "tearing" de pantalla (evita fallos visuales)
        layout           = "dwindle", -- Algoritmo de organización (Dwindle organiza ventanas en espiral)
    },

    -- Decoraciones visuales: Sombras, redondeo y efecto de cristal (Blur)
    decoration = {
        rounding       = 10, -- Redondeo de las esquinas de las ventanas (en píxeles)
        rounding_power = 2,  -- Suavizado de la curva de las esquinas (2 es el estándar orgánico)

        active_opacity   = 1.0, -- Opacidad base de ventanas activas (1.0 = 100% visible)
        inactive_opacity = 1.0, -- Opacidad base de ventanas inactivas

        -- Configuración de las sombras bajo las ventanas
        shadow = {
            enabled      = true,       -- Activa las sombras de ventana
            range        = 4,          -- Alcance/difusión de la sombra en píxeles
            render_power = 3,          -- Intensidad y caída de la sombra (1 a 4)
            color        = 0xee1a1a1a, -- Color gris oscuro/negro semitransparente para la sombra
        },

        -- Motor de desenfoque de cristal (Frutiger Glass Blur)
        blur = {
            enabled           = true,  -- Activa el desenfoque traslúcido tras las ventanas
            size              = 1,     -- Radio/fuerza del desenfoque (6 o 8 dan un cristal esmerilado suave)
            passes            = 2,     -- Pasadas de procesado (2 evita el lavado/neblina blanca excesiva)
            new_optimizations = true,  -- Optimiza el uso de la GPU al calcular el blur
            ignore_opacity    = true,  -- CRUCIAL: Mantiene el blur visible sin importar la transparencia del tema
            vibrancy          = 0.0,   -- Ajustado en 0.0 elimina la sobreexposición de luz blanca saturada
            vibrancy_darkness = 0.9,   -- Mantiene el contraste oscuro para leer bien la terminal
        },
    },

    -- Reglas para el layout de ventanas tipo Dwindle
    dwindle = {
        preserve_split = true, -- Mantiene la dirección del corte al cerrar o abrir ventanas
    },

    -- Reglas para el layout alternativo tipo Master
    master = {
        new_status = "master", -- Las ventanas nuevas se convierten en la principal
    },

    -- Comportamiento de desplazamiento y pantallas
    scrolling = {
        fullscreen_on_one_column = true, -- Mantiene pantalla completa limpia en disposiciones verticales
    },

    -- Opciones misceláneas del sistema
    misc = {
        force_default_wallpaper = -1,    -- Desactiva el fondo por defecto de Hyprland (-1 usa el sistema)
        disable_hyprland_logo   = false, -- Muestra/oculta el logo o mascota de Hyprland al inicio
	font_family             = "JetBrainsMono Nerd Font",
    },

    -- Configuración de periféricos de entrada (Teclado y Touchpad)
    input = {
        kb_layout  = "us", -- Distribución del teclado en inglés
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1, -- La ventana gana el foco al pasar el puntero sobre ella
        sensitivity  = 0, -- Sensibilidad base del ratón (0 = sin aceleración añadida)

        touchpad = {
            natural_scroll = false, -- Desplazamiento tradicional en touchpad (no inverso)
        },
    },
})

-- Ajuste de sensibilidad específico para hardware de puntero dedicado
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
