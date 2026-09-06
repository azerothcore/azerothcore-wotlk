-- DB update 2025_10_07_01 -> 2025_10_09_00

-- Add Npcs to Rhino.
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 29931;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(29931, 29982, 0, 0, 'Drakkari Raider', 7, 0),
(29931, 29982, 1, 0, 'Drakkari Raider', 7, 0),
(29931, 29982, 2, 0, 'Drakkari Raider', 7, 0);

-- Remove Spawns (Drakkari Raider)
DELETE FROM `creature` WHERE `id1` = 29982;

-- Remove Guid SmartAI (Drakkari Raider)
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-127226, -127225, -127217)) AND (`source_type` = 0);

-- Remove Extra Flag Dont_override (Drakkari Raider)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ 134217728 WHERE (`entry` = 29982);

-- Edit SmartAI (Drakkari Rhino and Drakkari Raider)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (29931, 29982));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (29931, 29982));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29931, 0, 0, 0, 9, 0, 100, 514, 0, 0, 8000, 8000, 5, 40, 11, 55530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - Within 5-40 Range - Cast \'Charge\' (Normal Dungeon)'),
(29931, 0, 1, 0, 9, 0, 100, 516, 0, 0, 8000, 8000, 5, 40, 11, 58991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - Within 5-40 Range - Cast \'Charge\' (Heroic Dungeon)'),
(29931, 0, 2, 0, 0, 0, 100, 514, 0, 10000, 8000, 22000, 0, 0, 11, 55663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - In Combat - Cast \'Deafening Roar\' (Normal Dungeon)'),
(29931, 0, 3, 0, 0, 0, 100, 516, 0, 10000, 8000, 22000, 0, 0, 11, 58992, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - In Combat - Cast \'Deafening Roar\' (Heroic Dungeon)'),
(29931, 0, 4, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 0, 232, 1272070, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Data Set 0 2 - Start Path 1272070'),
(29931, 0, 5, 6, 108, 0, 100, 0, 3, 1272070, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Set Home Position'),
(29931, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 150, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Do Action ID 150'),
(29931, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 151, 0, 0, 0, 0, 0, 29, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Do Action ID 151'),
(29931, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 152, 0, 0, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - On Point 3 of Path 1272070 Reached - Do Action ID 152'),
(29982, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 5000, 11000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - In Combat - Cast \'Cleave\''),
(29982, 0, 1, 2, 72, 0, 100, 0, 150, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Action 150 Done - Exit vehicle'),
(29982, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1773.92, 748.702, 119.4, 3.1151, 'Drakkari Raider - On Action 150 Done - Set Home Position'),
(29982, 0, 3, 4, 72, 0, 100, 0, 151, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Action 151 Done - Exit vehicle'),
(29982, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1769.33, 743.685, 119.4, 3.1151, 'Drakkari Raider - On Action 151 Done - Set Home Position'),
(29982, 0, 5, 6, 72, 0, 100, 0, 152, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - On Action 152 Done - Exit vehicle'),
(29982, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1771.29, 738.667, 119.4, 3.1151, 'Drakkari Raider - On Action 152 Done - Set Home Position');
