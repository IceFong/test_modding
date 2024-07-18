PrefabFiles = {
	"neptune",
	"neptune_none",
    "wooden_sword",
    "pudding"
}

AddMinimapAtlas("images/map_icons/neptune.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local FOODTYPE = GLOBAL.FOODTYPE

-- The character select screen lines
STRINGS.CHARACTER_TITLES.neptune = "Neptune aka Purple Heart"
STRINGS.CHARACTER_NAMES.neptune = "Neptune"
STRINGS.CHARACTER_DESCRIPTIONS.neptune = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.neptune = "\"Quote\""
STRINGS.CHARACTER_SURVIVABILITY.neptune = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.NEPTUNE = require "speech_neptune"

-- The character's name as appears in-game 
STRINGS.NAMES.NEPTUNE = "Neptune"
STRINGS.SKIN_NAMES.neptune_none = "Neptune"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("neptune", "FEMALE", skin_modes)

TUNING.NEPTUNE_DAMAGE_MULTI = GetModConfigData("NEPTUNE_DAMAGE_MULTI")
TUNING.NEPTUNE_HUNGER_MULTI = GetModConfigData("NEPTUNE_HUNGER_MULTI")


-- Items data
    -- Wooden sword
TUNING.WOODEN_SWORD_DAMAGE = 40
TUNING.WOODEN_SWORD_MAX_USES = 100
STRINGS.NAMES.WOODEN_SWORD = "Wooden sword"
STRINGS.RECIPE_DESC.WOODEN_SWORD = "A sword made out of wood."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WOODEN_SWORD = "A sword made out of wood."
STRINGS.CHARACTERS.NEPTUNE.DESCRIBE.WOODEN_SWORD = "Fun fact, I picked it up from a trash can"

AddRecipe("wooden_sword", {
	Ingredient("log", 4)
}, RECIPETABS.WAR, TECH.NONE, nil, nil, nil, nil, "wooden_sword", "images/inventoryimages/wooden_sword.xml", "wooden_sword.tex")

    -- Pudding
STRINGS.NAMES.PUDDING = "Pudding"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PUDDING = "A lovely dessert after tiring labor day."
STRINGS.CHARACTERS.NEPTUNE.DESCRIBE.PUDDING = "PUDDINGGGGG~!"
TUNING.PUDDING_HEATLH = 16;
TUNING.PUDDING_HUNGER = 16;
TUNING.PUDDING_SANITY = 16;
local pudding_recipe = {
    name = "pudding",
    --one egg, two honey and one corn
    test = function (cooker, names, tags) return (names.bird_egg or names.bird_egg_cooked) and (tags.sweetener and tags.sweetener >= 2 and not tags.meat) and (names.corn or names.corn.cooked) end,
    priority = 1,
    weight = 1,
    foodtype = FOODTYPE.MEAT,
    health = TUNING.PUDDING_HEATLH,
    hunger = TUNING.PUDDING_HUNGER,
    sanity = TUNING.PUDDING_SANITY,
    cooktime = 1,
    potlevel = "high",
    tags = {"honeyed"},
    floater = {"med", nil, 0.6},
    card_def = {ingredients = {{"bird_egg", 1}, {"honey", 2}, {"corn", 1}} }
}
AddCookerRecipe("cookpot", pudding_recipe, true)
AddCookerRecipe("archive_cookpot", pudding_recipe, true)


