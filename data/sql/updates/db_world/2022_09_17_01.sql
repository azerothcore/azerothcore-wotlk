-- DB update 2022_09_17_00 -> 2022_09_17_01
--
DELETE FROM `creature_template_movement` WHERE `creatureId` = 15727;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15727, 1, 0, 0, 1, 0, 0, 0);

DELETE FROM `areatrigger_scripts` WHERE `ScriptName` = 'at_cthun_stomach_exit' AND `entry` = 4033;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4033, 'at_cthun_stomach_exit');

DELETE FROM `areatrigger_scripts` WHERE `ScriptName` = 'at_cthun_center' AND `entry` = 4036;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4036, 'at_cthun_center');
