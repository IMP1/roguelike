local controls = {}

controls.map = {
    {
        action = "quit",
        key = "q",
        modifiers = {"lctrl", "rctrl"},
    },
    {
        action = "help",
        key = "f1",
    },
    {
        action = "walk",
        args = { 
            direction = "up",
        },
        key = "w",
    },
    {
        action = "walk",
        args = { 
            direction = "left",
        },
        key = "a",
    },
    {
        action = "walk",
        args = { 
            direction = "down",
        },
        key = "s",
    },
    {
        action = "walk",
        args = { 
            direction = "right",
        },
        key = "d",
    },
    {
        action = "toggle_mode",
        args = {
            mode = "actions",
        }
        key = "space",
    },
    {
        action = "toggle_mode",
        args = {
            mode = "dialog",
        }
        key = "t",
    },
    {
        action = "toggle_mode",
        args = {
            mode = "combat",
        }
        key = "f",
    },
}

controls.actions = {
    {
        action = "toggle_mode",
        args = {
            mode = "map",
        }
        key = "escape",
    },
}

controls.all_commands = {
    "walk",
    "dash",
    "talk",
    "ask",
    "say",
    "throw",
    "pick up",
    "drop",
    "read",
    "open",
    "close",
    "search",
    "put on", -- / equip
    "take off", -- / unequip
    "shoot",
    "stab",
    "slash",
    "bash",
    "give", -- / stow
    "take",
    "inspect",
    "knock",
    "use",
    "eat", -- / drink
}

controls.dialog = {
    
}

controls.combat = {

}

return controls