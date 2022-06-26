--
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (15242, 18707, 22441, 15114, 15043);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES (15242, 1, 0, 1, 0, 0, 0),
(18707, 1, 0, 1, 0, 0, 0),
(22441, 1, 0, 1, 0, 0, 0),
(15114, 1, 1, 0, 0, 0, 0),
(15043, 1, 1, 0, 0, 0, 0);
