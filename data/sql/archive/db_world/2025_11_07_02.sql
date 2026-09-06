-- DB update 2025_11_07_01 -> 2025_11_07_02

-- Add Waypoints (Scarlet Miner)
DELETE FROM `waypoint_data` WHERE (`id` IN (2884100, 2884101));
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2884100, 1, 2376.9087, -5906.2495, 108.593, NULL, 0, 1, 0, 100, 0),
(2884100, 2, 2340.1587, -5903.4995, 102.593, NULL, 0, 1, 0, 100, 0),
(2884100, 3, 2306.4087, -5904.7495, 90.593, NULL, 0, 1, 0, 100, 0),
(2884100, 4, 2292.6587, -5917.4995, 82.343, NULL, 0, 1, 0, 100, 0),
(2884100, 5, 2285.6587, -5943.4995, 64.093, NULL, 0, 1, 0, 100, 0),
(2884100, 6, 2271.9087, -5968.4995, 49.843, NULL, 0, 1, 0, 100, 0),
(2884100, 7, 2248.1587, -5978.4995, 36.843, NULL, 0, 1, 0, 100, 0),
(2884100, 8, 2234.6587, -5996.9995, 25.842999, NULL, 0, 1, 0, 100, 0),
(2884100, 9, 2223.4087, -6014.9995, 11.5929985, NULL, 0, 1, 0, 100, 0),
(2884100, 10, 2216.1587, -6035.9995, 7.3429985, NULL, 0, 1, 0, 100, 0),
(2884100, 11, 2195.4087, -6061.2495, 6.3429985, NULL, 0, 1, 0, 100, 0),
(2884100, 12, 2184.4087, -6091.9995, 2.0929985, NULL, 0, 1, 0, 100, 0),
(2884100, 13, 2179.6587, -6120.2495, 1.5929985, NULL, 0, 1, 0, 100, 0),
(2884100, 14, 2175.4087, -6142.9995, 1.5929985, NULL, 0, 1, 0, 100, 0),
(2884100, 15, 2167.9087, -6159.4995, 1.8429985, NULL, 0, 1, 0, 100, 0),
(2884100, 16, 2149.4087, -6161.4995, 1.5929985, NULL, 0, 1, 0, 100, 0),
(2884100, 17, 2134.9087, -6166.2495, 0.8429985, NULL, 0, 1, 0, 100, 0),
(2884100, 18, 2130.9087, -6173.2495, 4.3429985, NULL, 0, 1, 0, 100, 0),
(2884100, 19, 2125.9087, -6180.7495, 10.0929985, NULL, 0, 1, 0, 100, 0),
(2884100, 20, 2123.4087, -6184.7495, 14.0929985, NULL, 0, 1, 0, 100, 0),
(2884100, 21, 2115.9087, -6196.2495, 13.8429985, NULL, 0, 1, 0, 100, 0),
(2884100, 22, 2119.1106, -6191.905, 13.275559, NULL, 0, 1, 0, 100, 0),
(2884101, 1, 2376.855, -5906.1553, 108.57493, NULL, 0, 1, 0, 100, 0),
(2884101, 2, 2340.105, -5903.4053, 102.57493, NULL, 0, 1, 0, 100, 0),
(2884101, 3, 2306.855, -5904.9053, 90.57493, NULL, 0, 1, 0, 100, 0),
(2884101, 4, 2292.855, -5917.6553, 82.32493, NULL, 0, 1, 0, 100, 0),
(2884101, 5, 2285.855, -5943.4053, 64.07493, NULL, 0, 1, 0, 100, 0),
(2884101, 6, 2272.105, -5968.4053, 49.82493, NULL, 0, 1, 0, 100, 0),
(2884101, 7, 2248.355, -5978.4053, 36.82493, NULL, 0, 1, 0, 100, 0),
(2884101, 8, 2234.605, -5996.9053, 25.824928, NULL, 0, 1, 0, 100, 0),
(2884101, 9, 2223.605, -6015.1553, 11.574928, NULL, 0, 1, 0, 100, 0),
(2884101, 10, 2216.105, -6035.9053, 7.3249283, NULL, 0, 1, 0, 100, 0),
(2884101, 11, 2195.105, -6059.4053, 6.3249283, NULL, 0, 1, 0, 100, 0),
(2884101, 12, 2184.855, -6087.1553, 3.0749283, NULL, 0, 1, 0, 100, 0),
(2884101, 13, 2180.605, -6119.4053, 1.5749283, NULL, 0, 1, 0, 100, 0),
(2884101, 14, 2177.605, -6149.4053, 1.8249283, NULL, 0, 1, 0, 100, 0),
(2884101, 15, 2188.855, -6170.4053, 1.3249283, NULL, 0, 1, 0, 100, 0),
(2884101, 16, 2213.105, -6165.4053, 1.0749283, NULL, 0, 1, 0, 100, 0),
(2884101, 17, 2241.855, -6160.4053, 2.0749283, NULL, 0, 1, 0, 100, 0),
(2884101, 18, 2269.105, -6163.4053, 2.3249283, NULL, 0, 1, 0, 100, 0),
(2884101, 19, 2269.605, -6168.9053, 2.3249283, NULL, 0, 1, 0, 100, 0),
(2884101, 20, 2270.105, -6174.6553, 5.8249283, NULL, 0, 1, 0, 100, 0),
(2884101, 21, 2270.605, -6180.9053, 9.824928, NULL, 0, 1, 0, 100, 0),
(2884101, 22, 2271.105, -6186.1553, 14.074928, NULL, 0, 1, 0, 100, 0),
(2884101, 23, 2273.855, -6196.4053, 13.824928, NULL, 0, 1, 0, 100, 0),
(2884101, 24, 2273.0032, -6191.717, 13.239414, NULL, 0, 1, 0, 100, 0);

-- Remove Script Names.
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` IN (28817, 28833, 28841));
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE (`entry` = 190767);

-- Set spell target position for Mine Car spawn.
UPDATE `spell_target_position` SET `PositionX` = 2389.58, `PositionY` = -5901.18, `PositionZ` = 109.02134, `Orientation` = 0 WHERE `ID` = 52462;

-- Set Unit Flag for Mine Car (immune_to_npc)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |512 WHERE (`entry` = 28817);

-- Set SmartAI (Mine Car)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28817;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28817);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28817, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 25703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mine Car - On Just Summoned - Morph To Model 25703'),
(28817, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 28841, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2382.171, -5899.672, 107.74545, 0, 'Mine Car - On Just Summoned - Summon Creature \'Scarlet Miner\''),
(28817, 0, 2, 0, 8, 0, 100, 0, 52465, 0, 0, 0, 0, 0, 29, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mine Car - On Spellhit \'Drag Mine Cart\' - Start Follow Invoker');

-- Set SmartAI (Scarlet Miner)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28841;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28841);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28841, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2884100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Summoned - Run Script'),
(28841, 0, 1, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2884101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 0 Finished - Run Script');

-- Set Scarlet Miner Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2884100, 2884101));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2884100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Set Run Off'),
(2884100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 1, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Move To Owner Or Summoner'),
(2884100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Say Line 0'),
(2884100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Cast \'Drag Mine Cart\''),
(2884100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Set Run On'),
(2884100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 2884100, 2884101, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Start Random Path 2884100-2884101'),
(2884101, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Set Orientation Owner Or Summoner'),
(2884101, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Say Line 1'),
(2884101, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 28, 52465, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Remove Aura \'Drag Mine Cart\''),
(2884101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Despawn Instant'),
(2884101, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - Actionlist - Despawn Instant');

-- Set SmartAI (Scarlet Fleet Defender)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28834;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28834);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28834, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Fleet Defender - On Just Died - Despawn In 3000 ms'),
(28834, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 5000, 8000, 0, 0, 11, 52566, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Fleet Defender - In Combat - Cast \'Shoot\'');

-- Update SmartAI (Scarlet Cannon)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28850;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28850) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28850, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - On Just Died - Despawn In 3000 ms');
