-- DB update 2022_07_01_02 -> 2022_07_01_03
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (15242, 18707, 22441, 8276);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES (15242, 1, 0, 1, 0, 0, 0),
(18707, 1, 0, 1, 0, 0, 0),
(22441, 1, 0, 1, 0, 0, 0),
(8276, 1, 0, 1, 0, 0, 0);
