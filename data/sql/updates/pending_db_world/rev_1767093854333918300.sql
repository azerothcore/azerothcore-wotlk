--
DELETE FROM `creature_queststarter` WHERE (`quest` = 3789) AND (`id` IN (5111, 6740));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(6740, 3789);

DELETE FROM `creature_queststarter` WHERE (`quest` = 3790) AND (`id` IN (6740, 5111));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(5111, 3790);
