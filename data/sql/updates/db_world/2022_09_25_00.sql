-- DB update 2022_09_24_01 -> 2022_09_25_00
--
DELETE FROM `creature_questender` WHERE `id` = 15738 AND `quest` = 8832;
DELETE FROM `creature_questender` WHERE `id` = 15738 AND `quest` = 8815;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(15738, 8815);
