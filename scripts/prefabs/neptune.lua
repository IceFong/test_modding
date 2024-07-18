local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

	Asset( "IMAGE", "images/saveslot_portraits/neptune.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/neptune.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/neptune.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/neptune.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/neptune_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/neptune_silho.xml" ),

    Asset( "IMAGE", "bigportraits/neptune.tex" ),
    Asset( "ATLAS", "bigportraits/neptune.xml" ),
	
	Asset( "IMAGE", "images/map_icons/neptune.tex" ),
	Asset( "ATLAS", "images/map_icons/neptune.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_neptune.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_neptune.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_neptune.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_neptune.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_neptune.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_neptune.xml" ),
	
	Asset( "IMAGE", "images/names_neptune.tex" ),
    Asset( "ATLAS", "images/names_neptune.xml" ),
	
	Asset( "IMAGE", "images/names_gold_neptune.tex" ),
    Asset( "ATLAS", "images/names_gold_neptune.xml" ),

    Asset( "MINIMAP_IMAGE", "neptune_hdd")
}

-- Your character's stats
TUNING.NEPTUNE_HEALTH = 128
TUNING.NEPTUNE_HUNGER = 256
TUNING.NEPTUNE_SANITY = 128

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.NEPTUNE = {
	"wooden_sword"
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.NEPTUNE
end
local prefabs = FlattenTree(start_inv, true)


local HDDMODE_NAMES =
{
    "hdd",
    "hddnextform"
}

local WEREMODES = { 
	NONE = 0,
	HDD = 1,
	NEXTFORM = 2
}

local SKIN_MODE_DATA =
{
    ["normal_skin"] = {
        bank = "wilson",
        shadow = { 1.3, .6 },
        debuffsymbol = { "headbase", 0, -200, 0 },
    },
    ["hdd_skin"] = {
        bank = "hdd",
        hideclothing = true,
        shadow = { 1.3, .6 },
        debuffsymbol = { "headbase", 0, -200, 0 },
    },
    ["hddnextform_skin"] = {
        bank = "hddnextform",
        hideclothing = true,
        shadow = { 1.3, .6 },
        debuffsymbol = { "headbase", 0, -200, 0 },
    },
    ["ghost_skin"] = {
        bank = "ghost",
        shadow = { 1.3, .6 },
    },
}

local function IsHDDMode(mode)
    return HDDMODE_NAMES[mode] ~= nil
end

local function SetHDDMode(inst, mode, skiphudfx)
    if IsHDDMode(mode) then
        -- sound
		-- TheWorld:PushEvent("enabledynamicmusic", false)
        -- if not TheFocalPoint.SoundEmitter:PlayingSound("beavermusic") then
        --     TheFocalPoint.SoundEmitter:PlaySound(
        --         (mode == WEREMODES.BEAVER and "dontstarve/music/music_hoedown") or
        --         (mode == WEREMODES.MOOSE and "dontstarve/music/music_hoedown_moose") or
        --         (--[[mode == WEREMODES.GOOSE and]] "dontstarve/music/music_hoedown_goose"),
        --         "beavermusic"
        --     )
        -- end

        -- inst.HUD.controls.status:SetWereMode(true, skiphudfx)
        -- if inst.HUD.beaverOL ~= nil then
        --     inst.HUD.beaverOL:Show()
        -- end
		
        if not TheWorld.ismastersim then
            inst.CanExamine = false
            -- SetWereActions(inst, mode) -- mode speacial move
            -- SetWereVision(inst, mode)

			-- locomotor (ex: inst.components.locomotor.walkspeed = 5)
            -- if inst.components.locomotor ~= nil then
            --     inst.components.locomotor.runspeed =
            --         (mode == WEREMODES.BEAVER and TUNING.BEAVER_RUN_SPEED) or
            --         (mode == WEREMODES.MOOSE and TUNING.WEREMOOSE_RUN_SPEED) or
            --         (--[[mode == WEREMODES.GOOSE and]] TUNING.WEREGOOSE_RUN_SPEED)
            -- end
        end
    else
        -- TheWorld:PushEvent("enabledynamicmusic", true)
        -- TheFocalPoint.SoundEmitter:KillSound("beavermusic")

        -- inst.HUD.controls.status:SetWereMode(false, skiphudfx)
        -- if inst.HUD.beaverOL ~= nil then
        --     inst.HUD.beaverOL:Hide()
        -- end

        -- if not TheWorld.ismastersim then
        --     inst.CanExamine = nil
        --     SetWereActions(inst, mode)
        --     SetWereVision(inst, mode)
        --     if inst.components.locomotor ~= nil then
        --         inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED
        --     end
        -- end
    end
end

local function OnHDDModeDirty(inst) 
	if inst.HUD ~= nil and not inst:HasTag("playerghost") then
        -- SetHDDMode(inst, inst.hddmode:value())
    end
end

local function ChangeHDDModeValue(inst, newmode)
	-- check mode value
    if inst.hddmode:value() ~= newmode then
		-- if is hdd, do untransform, else addtag of hddtransform
		local userflagString = "CHARACTER_STATE_"..tostring(newmode)
        if IsHDDMode(inst.hddmode:value()) then
            if not IsHDDMode(newmode) then
                inst:RemoveTag("hddplayer")
            end
            -- inst:RemoveTag(inst.hddmode:value() == WEREMODES.BEAVER and "beaver" or ("were"..hddmode_NAMES[inst.hddmode:value()]))
            inst.Network:RemoveUserFlag(USERFLAGS[userflagString])
        else
            inst:AddTag("hddplayer")
        end

        inst.hddmode:set(newmode)

        if IsHDDMode(newmode) then
            inst:AddTag(HDDMODE_NAMES[inst.hddmode:value()])
            inst.Network:AddUserFlag(userflagString)
            inst.overrideskinmode = HDDMODE_NAMES[newmode].."_skin"
            inst.overrideghostskinmode = "ghost_skin"
            inst:PushEvent("starthddplayer") --TODO event for hdd transform animation?
		
        else
            inst.overrideskinmode = nil
            inst.overrideghostskinmode = nil
            inst:PushEvent("stophddplayer") --event for sentientaxe
        end

        OnHDDModeDirty(inst)
    end
end

local function CustomSetSkinMode(inst, skinmode)
    local data = SKIN_MODE_DATA[skinmode]
    if data.hideclothing then
        inst.components.skinner:HideAllClothing(inst.AnimState)
    end
    inst.AnimState:SetBank(data.bank)
    inst.components.skinner:SetSkinMode(skinmode)
    inst.DynamicShadow:SetSize(unpack(data.shadow))
    if data.debuffsymbol ~= nil then
        inst.components.debuffable:SetFollowSymbol(unpack(data.debuffsymbol))
    end
    if inst.components.freezable ~= nil then
        inst.components.freezable:SetShatterFXLevel(data.freezelevel or 4)
    end
end

-- When the character is revived from human
local function OnBecameHuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "neptune_speed_mod", 1)
end

local function OnBecameGhost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "neptune_speed_mod")
end

local function OnBecameHDD(inst)
    CustomSetSkinMode(inst, "hdd_skin")

    inst.MiniMapEntity:SetIcon("neptune_hdd.png")

end



-- When loading or spawning the character
-- local function OnLoad(inst)
--     inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
--     inst:ListenForEvent("ms_becameghost", OnBecameGhost)

--     if inst:HasTag("playerghost") then
--         OnBecameGhost(inst)
--     else
--         OnBecameHuman(inst)
--     end
-- end

local function onentityreplicated(inst)
    if inst.sg ~= nil and inst:HasTag("wereplayer") then
        inst.sg:GoToState("idle")
    end	
end

local function OnPreLoad(inst, data)
    if data ~= nil and data.fullmoontriggered then
        if inst.fullmoontriggered then
            inst.components.wereness:Sethddmode(nil)
            inst.components.wereness:SetPercent(0, true)
        else
            inst.fullmoontriggered = true
        end
    end
    if data ~= nil then
        if data.isbeaver then
            onbecamebeaver(inst)
        elseif data.ismoose then
            onbecamemoose(inst)
        elseif data.isgoose then
            onbecamegoose(inst)
        else
            return
        end
        inst.sg:GoToState("idle")
    end
end

local function OnLoad(inst)
    inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
    inst:ListenForEvent("ms_becameghost", OnBecameGhost)

	if IsHDDMode(inst.hddmode:value()) and not inst:HasTag("playerghost") then
        -- inst.components.inventory:Close()
		print();
    elseif not inst:HasTag("playerghost") then
        OnBecameHuman(inst)
    else 
        OnBecameGhost(inst)
    end
end

local function OnSave(inst, data)
    if IsHDDMode(inst.hddmode:value()) then
        data["is"..HDDMODE_NAMES[inst.hddmode:value()]] = true
    end
end

local function OnPlayerHDDActivated() 
    
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "neptune.tex" )
	inst.hddmode = net_tinybyte(inst.GUID, "neptune.hddmode", "hddmodedirty")

    inst:ListenForEvent("onplayerhddactivated", OnPlayerHDDActivated)

end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.NEPTUNE_HEALTH)
	inst.components.hunger:SetMax(TUNING.NEPTUNE_HUNGER)
	inst.components.sanity:SetMax(TUNING.NEPTUNE_SANITY)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1 * TUNING.NEPTUNE_DAMAGE_MULTI
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.NEPTUNE_HUNGER_MULTI
	
	inst.OnLoad = OnLoad
	inst.OnSave = OnSave
    inst.OnNewSpawn = OnLoad
	inst.OnPreLoad = OnPreLoad
	
end

return MakePlayerCharacter("neptune", prefabs, assets, common_postinit, master_postinit, prefabs)
