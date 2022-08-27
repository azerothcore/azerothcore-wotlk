-- DB update 2022_07_09_09 -> 2022_07_09_10
--
DELETE FROM `spell_target_position` WHERE `id` = 24466;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES
(24466, 0, 309, -11582.9, -1251.15, 90, 5.04179);

UPDATE `creature` SET `spawntimesecs` = 20 WHERE `id1` = 14826;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14826;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14826) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14826, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sacrificed Troll - On Just Died - Despawn In 5000 ms'),
(14826, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 9, 14826, 0, 100, 2, 0, 0, 0, 0, 'Sacrificed Troll - On Respawn - Respawn Closest Creature \'Sacrificed Troll\'');

SET @LEADERGUID := 49081;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 49078, 49079, 49080, 49082, 49083, 49084, 49085, 49086, 49087);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 49078, 0, 0, 3),
(@LEADERGUID, 49079, 0, 0, 3),
(@LEADERGUID, 49080, 0, 0, 3),
(@LEADERGUID, 49082, 0, 0, 3),
(@LEADERGUID, 49083, 0, 0, 3),
(@LEADERGUID, 49084, 0, 0, 3),
(@LEADERGUID, 49085, 0, 0, 3),
(@LEADERGUID, 49086, 0, 0, 3),
(@LEADERGUID, 49087, 0, 0, 3);

UPDATE `creature_template_spell` SET `Spell` = 24261 WHERE `CreatureID` = 15112 AND `Index` = 0;

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_random_aggro', 'spell_delusions_of_jindo');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23878, 'spell_random_aggro'),
(24306, 'spell_delusions_of_jindo');

UPDATE `creature_template` SET `speed_run` = 1.14286, `speed_walk` = 1.32 WHERE `entry` = 11380;
