-- DB update 2024_12_01_02 -> 2024_12_01_03
--
DELETE FROM `creature_queststarter` WHERE `id` IN (4485, 10540) AND `quest` = 1361;
-- Adds NPCs Vol'jin and Belgrom Rockmaul as Quest Starters for Regthar Deathgate
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(4485, 1361),
(10540, 1361);
