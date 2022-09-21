-- Lava Spawn (12265)
DELETE FROM `creature_text` WHERE `CreatureID`=12265 AND `BroadcastTextId`=7570;
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES (12265, '%s splits into two new Lava Spawns!', 16, 100, 7570, 'Lava Spawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12265);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12265, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 3000, 3000, 0, 11, 19391, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Lava Spawn - In Combat - Cast \'Fireball\''),
(12265, 0, 1, 2, 0, 0, 100, 0, 12000, 12000, 12000, 12000, 0, 11, 19569, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lava Spawn - In Combat - Cast \'Split\''),
(12265, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 19570, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lava Spawn - In Combat - Cast \'Split\''),
(12265, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lava Spawn - In Combat - Say Line 0'),
(12265, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lava Spawn - In Combat - Despawn Instant');
