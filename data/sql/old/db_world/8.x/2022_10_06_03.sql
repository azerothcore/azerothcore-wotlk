-- DB update 2022_10_06_02 -> 2022_10_06_03
--
DELETE FROM `creature_template_movement` WHERE `creatureId` IN (21221, 15728, 15334, 15802, 15725, 15726);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(21221, 1, 0, 0, 1, 0, 0, 0),
(15728, 1, 0, 0, 1, 0, 0, 0),
(15334, 1, 0, 0, 1, 0, 0, 0),
(15802, 1, 0, 0, 1, 0, 0, 0),
(15725, 1, 0, 0, 1, 0, 0, 0),
(15726, 1, 0, 0, 1, 0, 0, 0);

UPDATE `creature_template` SET `unit_flags` = `unit_flags` |33554432 WHERE `entry` IN (15910, 15904, 15896);
