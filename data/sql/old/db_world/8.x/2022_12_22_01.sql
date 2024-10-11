-- DB update 2022_12_22_00 -> 2022_12_22_01
-- 
DELETE FROM `player_factionchange_quests` WHERE `alliance_id` = 10382;
INSERT INTO `player_factionchange_quests` (`alliance_id`, `horde_id`) VALUES
(10382, 10388);
