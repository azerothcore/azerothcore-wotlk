-- DB update 2023_06_08_00 -> 2023_06_09_00
--
DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (18176,18177,18178,18179,19897,19898,19899,19900));
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`, `Rooted`) VALUES
(18176, 1, 1),
(18177, 1, 1),
(18178, 1, 1),
(18179, 1, 1),
(19897, 1, 1),
(19898, 1, 1),
(19899, 1, 1),
(19900, 1, 1);
