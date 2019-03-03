-- --------------------------------------------------------------------------------------
-- Initialize
-- --------------------------------------------------------------------------------------
SET
@StartEntry := 601075,
@StartGUID  := 601075,
@EndEntry	:= 601077,
@EndGUID	:= 601077,
@StartGossipEntry := 60175,
@EndGossipEntry := 60177;

DELETE FROM `creature_template` WHERE `entry` >= @StartEntry AND `entry` <= @EndEntry;
DELETE FROM `creature` WHERE `guid` >= @StartGUID AND `guid` <= @EndGUID;
DELETE FROM `creature_equip_template` WHERE `CreatureID`>= @StartEntry AND `CreatureID` <= @EndEntry;
DELETE FROM `creature_template_addon` WHERE `entry` >= @StartEntry AND `entry` <= @EndEntry;
DELETE FROM `npc_text` WHERE `ID` >= @StartEntry AND `ID` <= @EndEntry;
DELETE FROM `gossip_menu` WHERE `MenuID` >= @StartGossipEntry AND `MenuID` <= @EndGossipEntry; 

-- --------------------------------------------------------------------------------------
-- TABLE (NPC_LOREMASTER)
-- --------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `npc_loremaster`;
CREATE TABLE `npc_loremaster` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=601075 DEFAULT CHARSET=utf8 COMMENT='Loremaster NPC Module';

-- --------------------------------------------------------------------------------------
-- NPC Template
-- --------------------------------------------------------------------------------------
USE azer_world;
SET
@Name 		:= "Crom",
@Title 		:= "Loremaster",
@Model 		:= 14395, -- Highlord Demitrian
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 3,
@Scale		:= 1.0,
@Rank		:= 0,
@Type 		:= 7,
@TypeFlags 	:= 68,
@AIName		:= "ReactorAI",
@MinDmg		:= 10000,
@MaxDmg		:= 50000,
@RegenHealth:= 1,
@FlagsExtra := 2,
@Exp		:= 2,
@Script 	:= "Loremaster_NPC",
@Icon 		:= "Speak";

-- --------------------------------------------------------------------------------------
-- 601075 - Michel Koiter's Shrine
-- https://web.archive.org/web/20160329220904/http://www.sonsofthestorm.com:80/memorial_twincruiser.html
-- --------------------------------------------------------------------------------------

SET
@Location := "Koiter\'s Shrine",
@NPCText := "Hail $N.$B$BYou are at the Shrine of the Fallen Warrior - Michel Martin Koiter (May 3, 1984 – March 18, 2004). Michel was one of Blizzard\'s premium artists, and was known under the name of \"Twincruiser\", an artistic collaboration with his twin brother René Koiter. He died at age 19 of unexpected heart failure. A flu had struck him, which in a matter of days would become progressively worse until his body could no longer cope. The cause of his death was never really understood.$B$BMichel's memorial is likely the first permanent in-game structure dedicated to a player. It is said he did a lot of work on the Northern Barrens where you now stand. His orc warrior, laying in rest on the altar behind the spirit healer, is dressed exactly how he last appeared in the World of Warcraft beta. The altar itself is inscribed with his initials \"MK\".$B$B\"it'll be all right...\"$B$BTo the family who keeps$BMichel's flame burning bright.$BThere is no greater glory$Bthat has been so worth the fight..$BBecause some things are just worth fighting for.";
-- --------------------------------------------------------------------------------------
INSERT INTO `npc_loremaster` VALUES (@StartGUID, '-378.273', '-2181.21', '156.325', '3.18949', '1', @Location);
INSERT INTO `creature_template` (entry, name, subname, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, dmgschool, BaseAttackTime, RangeAttackTime, unit_class, unit_flags, unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, mindmg, maxdmg, RacialLeader, RegenHealth, mechanic_immune_mask, flags_extra, exp, modelid1, modelid2, modelid3, modelid4, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, ScriptName, gossip_menu_id) VALUES (@StartEntry, @Name, @Title, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1.1, 1.17, @Scale, @Rank, 0, 500, 500, 1, 0, 0, 1, 0, 0, 0, 0, 0, @Type, @TypeFlags, 0, 0, 0, 0, 0, 0, 0, @AIName, 0, 3, 1, 1, 1, 1, @MinDmg, @MaxDmg, 0, @RegenHealth, 0, @FlagsExtra, @Exp, @Model, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @Script, @StartGossipEntry);
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@StartEntry, @NPCText);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@StartGossipEntry, @StartEntry);
INSERT INTO `creature_equip_template` VALUES (@StartEntry, '1', '45861', '1906', '0', '18019'); -- Diamond Tipped Cane, Torch
INSERT INTO `creature_template_addon` VALUES (@StartEntry, '0', '0', '0', '0', '0', '');
INSERT INTO `creature` VALUES (@StartGUID, @StartEntry, '1','0','0','1', '1', '0', '1', '-383.47', '-2181.44', '157.881', '0.135076', '300', '0', '0', '12600', '0', '0', '0', '0', '0',  '@Script', 0);

-- --------------------------------------------------------------------------------------
-- 601076 - Dead King's Crypt
-- http://conan.wikia.com/wiki/The_Thing_in_the_Crypt
-- --------------------------------------------------------------------------------------

SET 
@Location := "Dead King\'s Crypt",
@Entry := 601076,
@GUID  := 601076,
@GossipEntry := 60176,
@NPCText := "Hail $N.$B$BThis crypt pays homage to the movie Conan the Barbarian. Having two days ago escaped the Hyperborean slave pens, Conan is chased by wolves, much like those found roaming the Badlands, as he runs across the plains. Making his way atop a hill of boulders, with the wolves almost upon him, he notices a small crack in the rocks - a cave entrance. As the wolves continue to prowl outside the cave refusing to enter, Conan enters the cave and makes his way to the inner chamber where he comes upon a decaying treasure room. At the far end, seated on a large throne, is a crowned skeleton staring at him with cold dead eyes. Beneath one hand lies an ancient and impressive looking sword.$B$BEnter the chamber $N. The sword in this crypt is clickable, yet it has no resulting action; a placeholder for a quest long forgotten. No further information exists.";
-- --------------------------------------------------------------------------------------
INSERT INTO `npc_loremaster` VALUES (@GUID, '-6581.37', '-3485.41', '318.13', '0.474687', '0', @Location);
INSERT INTO `creature_template` (entry, name, subname, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, dmgschool, BaseAttackTime, RangeAttackTime, unit_class, unit_flags, unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, mindmg, maxdmg, RacialLeader, RegenHealth, mechanic_immune_mask, flags_extra, exp, modelid1, modelid2, modelid3, modelid4, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, ScriptName, gossip_menu_id) VALUES (@Entry, @Name, @Title, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1.1, 1.17, @Scale, @Rank, 0, 500, 500, 1, 0, 0, 1, 0, 0, 0, 0, 0, @Type, @TypeFlags, 0, 0, 0, 0, 0, 0, 0, @AIName, 0, 3, 1, 1, 1, 1, @MinDmg, @MaxDmg, 0, @RegenHealth, 0, @FlagsExtra, @Exp, @Model, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @Script, @GossipEntry);
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, @NPCText);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@GossipEntry, @Entry);
INSERT INTO `creature_equip_template` VALUES (@Entry, '1', '45861', '1906', '0', '18019'); -- Diamond Tipped Cane, Torch
INSERT INTO `creature_template_addon` VALUES (@Entry, '0', '0', '0', '0', '0', '');
INSERT INTO `creature` VALUES  (@GUID, @Entry, '0','0','0','1','1','0','1','-6571.03','-3465.89','304.625','5.50124','300','0','0','12600','0','0','0','0','0', '@Script', 0);

-- --------------------------------------------------------------------------------------
-- 601075 - Shatterspear Vale
-- https://wow.gamepedia.com/Shatterspear_Vale
-- --------------------------------------------------------------------------------------

SET 
@Location := "Shatterspear Vale",
@Entry := 601077,
@GUID  := 601077,
@GossipEntry := 60177,
@NPCText := "Hail $N.$B$BThe path that lies before you leads to Shatterspear Vale, home of the Shatterspear Tribe. This unreachable area was included by the designers as eye-candy while on the flight path through Ashenvale. Prior to the Cataclysm, it could only reached by inventive use of spells, scrolls, and safe-falling through a void from the mountaintops of Winterspring. $B$BExplore the area and learn all you can $N. And if you come across my very old friend Voriya, give her my regards.";
-- --------------------------------------------------------------------------------------
INSERT INTO `npc_loremaster` VALUES (@GUID, '7443.72', '-1690.19', '194.643', '5.49535', '1', @Location);
INSERT INTO `creature_template` (entry, name, subname, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, rank, dmgschool, BaseAttackTime, RangeAttackTime, unit_class, unit_flags, unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, mindmg, maxdmg, RacialLeader, RegenHealth, mechanic_immune_mask, flags_extra, exp, modelid1, modelid2, modelid3, modelid4, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, ScriptName, gossip_menu_id) VALUES (@Entry, @Name, @Title, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1.1, 1.17, @Scale, @Rank, 0, 500, 500, 1, 0, 0, 1, 0, 0, 0, 0, 0, @Type, @TypeFlags, 0, 0, 0, 0, 0, 0, 0, @AIName, 0, 3, 1, 1, 1, 1, @MinDmg, @MaxDmg, 0, @RegenHealth, 0, @FlagsExtra, @Exp, @Model, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @Script, @GossipEntry);
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, @NPCText);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (@GossipEntry, @Entry);
INSERT INTO `creature_equip_template` VALUES (@Entry, '1', '45861', '1906', '0', '18019'); -- Diamond Tipped Cane, Torch
INSERT INTO `creature_template_addon` VALUES (@Entry, '0', '0', '0', '0', '0', '');
INSERT INTO `creature` VALUES (@GUID, @Entry, '1', '0', '0', '1', '1', '0', '1', '7452.25', '-1694.05', '195.624', '3.19806', '300', '0', '0', '12600', '0', '0', '0', '0', '0',  '@Script', 0);
