-- DB update 2022_12_06_45 -> 2022_12_07_00
-- Starter
DELETE FROM `creature_queststarter` WHERE (`quest` = 10259) AND (`id` IN (19942));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(19942, 10259);
-- Ender
DELETE FROM `creature_questender` WHERE (`quest` = 10259) AND (`id` IN (19942));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(19942, 10259);
