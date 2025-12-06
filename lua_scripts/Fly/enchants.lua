local npcid = 700031

-- Mapear cada opção para um ID de vendedor
local VENDORS = {
    [0]   = 700100, -- Head
    [2]   = 700101, -- Shoulder
    [14]  = 700102, -- Cloak
    [4]   = 700103, -- Chest
    [8]   = 700104, -- Bracer
    [9]   = 700105, -- Gloves
    [6]   = 700106, -- Waist
    [7]   = 700107, -- Leg
    [15]  = 700108, -- Feet
    [151] = 700109, -- Weapon
    [171] = 700110, -- Ranged
    [161] = 700111, -- Shields
}

-- Menu principal com ícones e texto formatado
local MENU_ITEMS = {
    {"|TInterface\\icons\\inv_helmet_98:30|t Head ", 0},
    {"|TInterface\\icons\\inv_shoulder_62:30|t Shoulder ", 2},
    {"|TInterface\\icons\\inv_misc_cape_20:30|t Back ", 14},
    {"|TInterface\\icons\\inv_chest_plate_23:30|t Chest ", 4},
    {"|TInterface\\icons\\inv_bracer_15:30|t Wrist ", 8},
    {"|TInterface\\icons\\inv_gauntlets_62:30|t Glove ", 9},
    {"|TInterface\\icons\\inv_belt_33:30|t Waist ", 6},
    {"|TInterface\\icons\\inv_pants_plate_27:30|t Leg ", 7},
    {"|TInterface\\icons\\inv_boots_plate_06:30|t Feet ", 15},
    {"|TInterface\\icons\\inv_axe_113:30|t Weapon ", 151},
    --{"|TInterface\\icons\\inv_pants_plate_27:30|t Ranged Weapon ", 171},
    --{"|TInterface\\icons\\inv_shield_31:30|t Shields ", 161},
}

-- Ao interagir com o NPC
local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    for _, item in ipairs(MENU_ITEMS) do
        player:GossipMenuAddItem(1, item[1], 1, item[2])
    end
    player:GossipSendMenu(1, creature)
end

-- Ao selecionar uma opção
local function OnGossipSelect(event, player, creature, sender, intid, code)
    local vendorId = VENDORS[intid]
    if vendorId then
        player:SendListInventory(creature, vendorId)
    else
        player:SendBroadcastMessage("Vendedor não encontrado.")
    end
end

RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
