-- DB update 2025_05_04_04 -> 2025_05_05_00

-- Set Don't Override SmartAI on the Stallions
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` IN(28605));

-- Change Respawn Timers for Stallions/Mares/Colts
UPDATE `creature` SET `spawntimesecs` = 60 WHERE (`id1` IN(28605, 28606, 28607));

-- Set SmartAI for Stallions, Mare and Colts
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28605;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28605) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28605, 0, 0, 1, 28, 0, 100, 0, 500, 500, 0, 0, 0, 0, 5, 377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Passenger Removed - Play Emote 377'),
(28605, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Passenger Removed - Despawn In 5000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28606;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28606) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28606, 0, 0, 1, 28, 0, 100, 0, 500, 500, 0, 0, 0, 0, 5, 377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Passenger Removed - Play Emote 377'),
(28606, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Passenger Removed - Despawn In 5000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28607;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28607) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28607, 0, 0, 1, 28, 0, 100, 0, 500, 500, 0, 0, 0, 0, 5, 377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Passenger Removed - Play Emote 377'),
(28607, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Passenger Removed - Despawn In 5000 ms');

-- Move rows numbers for two Guid SmartAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129210);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129210, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921000'),
(-129210, 0, 3, 4, 108, 0, 100, 0, 8, 12921000, 0, 0, 0, 0, 234, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Point 8 of Path 12921000 Reached - Stop Movement'),
(-129210, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2860500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Point 8 of Path 12921000 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129215);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129215, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921500'),
(-129215, 0, 3, 4, 109, 0, 100, 0, 0, 12921500, 0, 0, 0, 0, 41, 2000, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129236, 28606, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129246, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129249, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129251, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129248, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129245, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129214, 28605, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129235, 28606, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms');
