-- DB update 2022_07_25_04 -> 2022_07_25_05
--
DELETE FROM `creature_template_movement` WHERE `creatureId` = 15802;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15802, 1, 0, 0, 1, 0, 0, 0);

UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 15802;
