local ChatPrefix = "chat "
local ChannelName = "Chat"

local faction = {
    "|TInterface/icons/Inv_Misc_Tournaments_banner_Human.png:13|t",
    "|TInterface/icons/Inv_Misc_Tournaments_banner_Orc.png:13|t"
}
local class = {
    "|TInterface\\icons\\INV_Sword_27.png:13|t",
    "|TInterface\\icons\\INV_Hammer_01.png:13|t",
    "|TInterface\\icons\\INV_Weapon_Bow_07.png:13|t",
    "|TInterface\\icons\\INV_ThrowingKnife_04.png:13|t",
    "|TInterface\\icons\\INV_Staff_30.png:13|t",
    "|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:13|t",
    "|TInterface\\icons\\inv_jewelry_talisman_04.png:13|t",
    "|TInterface\\icons\\Spell_MageArmor.png:13|t",
    "|TInterface\\icons\\Spell_Nature_FaerieFire:13|t",
    "",
    "|TInterface\\icons\\Ability_Druid_Maul.png:13|t",
}
local race = {
    [1] = {
        "|TInterface/ICONS/Achievement_Character_Human_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Orc_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Dwarf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Nightelf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Undead_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Tauren_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Gnome_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Troll_Male:13|t",
        "",
        "|TInterface/ICONS/Achievement_Character_Bloodelf_Male:13|t",
        "|TInterface/ICONS/Achievement_Character_Draenei_Male:13|t",
    },
    [2] = {
        "|TInterface/ICONS/Achievement_Character_Human_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Orc_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Dwarf_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Nightelf_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Undead_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Tauren_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Gnome_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Troll_Female:13|t",
        "",
        "|TInterface/ICONS/Achievement_Character_Bloodelf_Female:13|t",
        "|TInterface/ICONS/Achievement_Character_Draenei_Female:13|t",
    }
}
local gm = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13|t"
local vipicon = "|TInterface/ICONS/inv_misc_gem_pearl_04:13|t"
local vipbadge = "|cff00FFFF[VIP]|r"
local chatfix = ""
local color = {
    "|cffC79C6E",
    "|cffF58CBA",
    "|cffABD473",
    "|cffFFF569",
    "|cffFFFFFF",
    "|cffC41F3B",
    "|cff0070DE",
    "|cff40C7EB",
    "|cff8787ED",
    "",
    "|cffFF7D0A",
}

local function OnCommand(event, player, command)
    
    if command:sub(1, ChatPrefix:len()) == ChatPrefix then
       -- local level = MODULE_VIP_GET_VIP_LEVEL(player:GetAccountId())
        local msg
		local pode_falar = player:CanSpeak()
        if player:IsGM() and (player:HasItem( 13449 ) == false) then
            msg = "|cff00FF00[" .. ChannelName .. "]|cffff0000<GM>" .. player:GetName() .. "]" .. gm .. "|r: " .. command:sub(ChatPrefix:len() + 1)
        elseif player:IsGM() and player:HasItem( 13449 ) then
            msg = "|cff00FF00[" .. ChannelName .. "]|cffFF4500 <DEV>" .. player:GetName() .. "] " .. gm .. "|r: " .. command:sub(ChatPrefix:len() + 1)
        --elseif pode_falar == true and (level == 3) then
            --msg = "|cff00FF00[" .. ChannelName .. "] "  .. color[player:GetClass()] ..vipbadge.. " [" .. player:GetName() .. "] " .. faction[player:GetTeam() + 1] .. "|r|cff00FF00|r: " .. command:sub(ChatPrefix:len() + 1)
        elseif pode_falar == true then
            msg = "|cff00FF00[" .. ChannelName .. "]"  .. color[player:GetClass()] ..chatfix.. " [" .. player:GetName() .. "] " .. faction[player:GetTeam() + 1] .. "|r|cff00FF00|r: " .. command:sub(ChatPrefix:len() + 1)
        else
            player:SendBroadcastMessage("Você está silenciado e não pode falar no chat global.")
            return false
        end

        SendWorldMessage(msg)
        return false
    end
end

RegisterPlayerEvent(42, OnCommand)
