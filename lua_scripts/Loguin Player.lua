local Races = {
	[1]  = "human",
	[2]  = "orc",
	[3]  = "dwarf",
	[4]  = "nightelf",
	[5]  = "undead",
	[6]  = "tauren",
	[7]  = "gnome",
	[8]  = "troll",
	[10] = "bloodelf",
	[11] = "draenei",
}

local Genders = {
	[0] = "male",
	[1] = "female",
}

local Classes = {
	[1] = "inv_sword_27",              -- Warrior
	[2] = "ability_thunderbolt",        -- Paladin
	[3] = "inv_weapon_bow_07",          -- Hunter
	[4] = "inv_throwingknife_04",       -- Rogue
	[5] = "inv_staff_30",               -- Priest
	[6] = "spell_deathknight_classicon",-- Death Knight
	[7] = "inv_jewelry_talisman_04",    -- Shaman
	[8] = "inv_staff_13",               -- Mage
	[9] = "spell_nature_faeriefire",    -- Warlock
	[11] = "inv_misc_monsterclaw_04",   -- Druid
}

local function getIcons(player)
	local classIcon = Classes[player:GetClass()] or "inv_misc_questionmark"
	local race = Races[player:GetRace()] or "orc"
	local gender = Genders[player:GetGender()] or "male"
	
	local stringIcons = "|TInterface\\icons\\"..classIcon..":15|t|TInterface\\icons\\Achievement_character_"..race.."_"..gender..":15|t"
	return stringIcons
end

local function OnLogin(event, player)
	if player:GetGMRank() < 1 then
		local icons = getIcons(player)
		local name = player:GetName()
		SendWorldMessage("|cff3BBFEA[Nemesis] : |cffEBFF22Jogador |cff52F539" .. name .. "  " .. icons .. " |cffEBFF22acabou de entrar.") 
	end
end

RegisterPlayerEvent(3, OnLogin)
