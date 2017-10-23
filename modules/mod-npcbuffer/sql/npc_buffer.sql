USE world;

-- ######################################################--
--	BUFFER NPC - 601016
-- ######################################################--
SET
@Entry 		:= 601016,
-- @Model 		:= 4309, -- Human Male Tuxedo
-- @Name 		:= "Bruce Buffer",
-- @Title 		:= "Ph.D.",
@Model 		:= 14612, -- Tauren Warmaster
@Name 		:= "Sergeant Hasselhoof",
@Title 		:= "",
@Icon 		:= "Speak",
@GossipMenu := 4110,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 81,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@AIName		:= "SmartAI",
@Script 	:= "buff_npc";

-- NPC
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (entry, modelid1, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, unit_class, unit_flags, type, type_flags, InhabitType, RegenHealth, flags_extra, AiName, ScriptName) VALUES
(@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, @Rank, 1, 2, @Type, @TypeFlags, 3, 1, @FlagsExtra, @AIName, @Script);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE `CreatureID`=@Entry AND `ID`=1;
INSERT INTO `creature_equip_template` VALUES (@Entry, 1, 1906, 0, 0, 18019); -- War Axe(14824), Torch