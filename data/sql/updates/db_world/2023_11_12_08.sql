-- DB update 2023_11_12_07 -> 2023_11_12_08
--
DELETE FROM `creature_text` WHERE `CreatureID` = 18185;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(18185,0,0,"The %s hisses loudly and prepares to attack.",16,0,100,0,0,0,14853,0,"Feralfen Serpent Spirit");

-- Feralfen Totem
UPDATE `creature_template` SET `unit_flags` = 2 WHERE (`entry` = 18186);

-- Feralfen Serpent Spirit
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18185;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18185);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18185, 0, 0, 1, 1, 0, 100, 0, 1500, 1500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Feralfen Serpent Spirit - Out of Combat - Say Line 0'),
(18185, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 80, 0, 0, 0, 0, 0, 0, 0, 'Feralfen Serpent Spirit - Out of Combat - Start Attacking');

-- Boha'mu Stairs
DELETE FROM `gameobject` WHERE (`id` = 182176);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(99924, 182176, 530, 0, 0, 1, 1, -281.944, 7238.6, 24.7725, 0, 0, 0, 0, 1, 180, 0, 1, '', 0);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q9847_a_spirit_ally';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(32037, 'spell_q9847_a_spirit_ally');
