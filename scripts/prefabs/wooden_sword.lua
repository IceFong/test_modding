local assets =
{
    Asset("ANIM", "anim/wooden_sword.zip"),
    Asset("ANIM", "anim/swap_wooden_sword.zip"),
	
    Asset("ATLAS", "images/inventoryimages/wooden_sword.xml"),
    Asset("IMAGE", "images/inventoryimages/wooden_sword.tex"),
}

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object","swap_wooden_sword", "wooden_sword")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function UpdateDamage(inst, owner) 
    -- if owne is HDD
end

local function fn()
  
    local inst = CreateEntity()
 
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
     
    MakeInventoryPhysics(inst)   
      
    inst.AnimState:SetBank("wooden_sword")
    inst.AnimState:SetBuild("wooden_sword")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("weapon")
	inst:AddTag("wooden_sword")

    MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- if HDD damage boost (TO-DO)
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.WOODEN_SWORD_DAMAGE)
    -- inst.components.weapon:SetOnAttack(UpdateDamage)
    -- inst.OnLoad = OnLoad

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.WOODEN_SWORD_MAX_USES)
    inst.components.finiteuses:SetUses(TUNING.WOODEN_SWORD_MAX_USES)

    inst.components.finiteuses:SetOnFinished(inst.Remove)
  
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "wooden_sword"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/wooden_sword.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	
	MakeHauntableLaunch(inst)
	
    return inst
end

return  Prefab("common/inventory/wooden_sword", fn, assets) 