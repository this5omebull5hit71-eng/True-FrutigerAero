hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar -c " .. os.getenv("HOME") .. "/True-Frutiger-Glass/waybar/config")
end)
