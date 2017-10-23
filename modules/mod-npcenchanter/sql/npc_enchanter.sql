USE world;

-- ######################################################--
--	ENCHANTER - 601015
-- ######################################################--
SET
@Entry 		:= 601015,
@Model 		:= 9353, -- Undead Necromancer
@Name 		:= "Beauregard Boneglitter",
@Title 		:= "Enchantments",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "npc_enchantment";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 11343, 0, 0, 18019); -- Black/Purple Staff, None

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, 'Good day $N. Beauregard Boneglitter at your service. I offer a vast array of gear enchantments for the aspiring adventurer.');