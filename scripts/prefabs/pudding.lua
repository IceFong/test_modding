local assets = {
    Asset("ANIM", "anim/pudding.zip"),
	
    Asset("ATLAS", "images/inventoryimages/pudding.xml"),
    Asset("IMAGE", "images/inventoryimages/pudding.tex"),
}

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("pudding")
    inst.AnimState:SetBuild("pudding")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("pudding")
    inst:AddTag("honeyed")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.ismeat = false
    inst.components.edible.foodtype = FOODTYPE.MEAT

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "pudding"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/pudding.xml"
    inst:AddComponent("stackable")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)
    -- inst:ListenForEvent("spawnedfromhaunt", OnSpawnedFromHaunt)

    inst.components.edible.healthvalue = TUNING.PUDDING_HEATLH;
    inst.components.edible.hungervalue = TUNING.PUDDING_HUNGER;
    inst.components.edible.sanityvalue = TUNING.PUDDING_SANITY;

    return inst

end

return  Prefab("common/inventory/pudding", fn, assets)