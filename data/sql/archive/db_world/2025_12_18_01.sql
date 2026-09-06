-- DB update 2025_12_18_00 -> 2025_12_18_01
--
DELETE FROM `creature_queststarter` WHERE (`quest` = 13057) AND (`id` IN (29445));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(29445, 13057);
