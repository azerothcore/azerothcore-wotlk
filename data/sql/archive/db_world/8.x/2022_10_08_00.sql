-- DB update 2022_10_07_06 -> 2022_10_08_00
--
DELETE FROM `creature_queststarter` WHERE (`quest` = 249);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(313, 249);
