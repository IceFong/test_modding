local assets =
{
	Asset( "ANIM", "anim/neptune.zip" ),
	Asset( "ANIM", "anim/ghost_neptune_build.zip" ),
}

local skins =
{
	normal_skin = "neptune",
	ghost_skin = "ghost_neptune_build",
}

return CreatePrefabSkin("neptune_none",
{
	base_prefab = "neptune",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"NEPTUNE", "CHARACTER", "BASE"},
	build_name_override = "neptune",
	rarity = "Character",
})