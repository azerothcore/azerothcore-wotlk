-- DB update 2026_02_13_01 -> 2026_02_13_02
DELETE FROM `creature_queststarter` WHERE (`quest` = 1823) AND (`id` IN (3041, 4595));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(3041, 1823),
(4595, 1823);
