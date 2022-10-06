-- DB update 2022_09_14_02 -> 2022_09_14_03
--
DELETE FROM `creature_queststarter` WHERE `id` = 15738 AND `quest` = 8815;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(15738, 8815);

DELETE FROM `creature_questender` WHERE `id` = 15738 AND `quest` = 8832;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(15738, 8832);
