-- This information tells other players more about the mod
name = "Neptune Charactor Mod"
description = "Neptune the god"
author = "CheeseCat"
version = "0.0.1" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = "/"

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"character",
}

configuration_options = {
    {name = "BasicStatusSettings", label = "Basic Status", options = {{description = "", data = ""},}, default = "",},  
        {
            name = "NEPTUNE_DAMAGE_MULTI",
            label = "Neptune's damage multiplier",
            options = {
                {description = "0.1 (Unplayable)", data = 0.1},
                {description = "0.25 (Powerless)", data = 0.25},
                {description = "0.5 (Weak)", data = 0.5},
                {description = "0.75 (Fair enough)", data = 0.75},
                {description = "1.0 (default)", data = 1.0},
                {description = "1.25 (Better)", data = 1.25},
                {description = "1.5 (Eazy)", data = 1.5},
                {description = "1.75 (Op)", data = 1.75},
                {description = "2.0 (Baby mode)", data = 2.0},
                {description = "10.0 (True god)", data = 10.0}
            },
            default = 1.0
        },
        {
            name = "NEPTUNE_HUNGER_MULTI",
            label = "Neptune's hunger multiplier",
            options = {
                {description = "0.25 (less)", data = 0.25},
                {description = "0.5 (less)", data = 0.5},
                {description = "0.75 (less)", data = 0.75},
                {description = "1.0 (default)", data = 1.0},
                {description = "1.25 (more)", data = 1.25},
                {description = "1.5 (more)", data = 1.5},
                {description = "1.75 (more)", data = 1.75},
                {description = "2.0 (more)", data = 2.0}
            },
            default = 1.0
        },
}
