-- DB update 2022_11_01_03 -> 2022_11_01_04
--
DELETE FROM `creature_queststarter` WHERE (`quest` = 14169) AND (`id` IN (34484));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(34484, 14169);

