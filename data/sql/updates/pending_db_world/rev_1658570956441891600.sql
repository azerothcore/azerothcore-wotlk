-- Spawns npc's from 13:00 - 17:01 (keep npc's spawned 1 min longer to make event over message at 17:00 works)
UPDATE `game_event` SET `start_time`= '2016-10-30 13:00:00', `length` = 241,  `description`= 'Stranglethorn Fishing Extravaganza - The Crew' WHERE `eventEntry` = 62;

-- Quests can be turned in 14:00 - 17:00
DELETE FROM `game_event` WHERE `eventEntry` = 90;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(90,'2016-10-30 14:00:00','2030-12-31 07:00:00',10080,180,0,0,'Stranglethorn Fishing Extravaganza - Turn-ins',0,2);

-- Assign script to Jang
UPDATE `creature_template` SET `scriptName`='npc_jang' WHERE `entry` = 15078;

-- Assign script to Fishbot5000
UPDATE `creature_template` SET `scriptName`='npc_fishbot_5000' WHERE `entry` = 15079;

-- Minimum fishing skill for Stranglethorn Vale Fishing Extravaganza quests is 150
DELETE FROM `quest_template_addon` WHERE `ID` IN (8194, 8193, 8225, 8224, 8221);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(8194,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8193,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8225,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8224,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1),
(8221,0,0,0,0,0,0,0,0,356,150,0,0,0,0,0,1);
