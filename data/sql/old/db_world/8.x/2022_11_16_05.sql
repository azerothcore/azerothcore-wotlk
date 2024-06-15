-- DB update 2022_11_16_04 -> 2022_11_16_05
--
DELETE FROM `player_factionchange_spells` WHERE `alliance_id`=17454;
INSERT INTO `player_factionchange_spells` VALUES
(17454,'Unpainted Mechanostrider',18990,'Brown Kodo');
