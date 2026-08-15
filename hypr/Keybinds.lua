---------------------
---- KEYBINDINGS ----
---------------------

-- 1. Declarar las variables PRIMERO para que existan en este archivo
local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun -show-icons"
local browser     = "flatpak run app.zen_browser.zen"

-- 2. Atajos principales
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))  -- Super + Enter para abrir Kitty
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))   -- Super + B para abrir Zen Browser
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

-- 3. Navegación de Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
