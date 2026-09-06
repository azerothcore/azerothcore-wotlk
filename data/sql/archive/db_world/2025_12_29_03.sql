-- DB update 2025_12_29_02 -> 2025_12_29_03
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` IN (27983, 27984, 27985));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27983);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27983, 0, 0, 0, 9, 0, 100, 0, 1200, 8000, 15000, 20000, 7, 40, 11, 22120, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Protector - Within 7-40 Range - Cast \'Charge\''),
(27983, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 8000, 16000, 0, 0, 11, 42724, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Protector - In Combat - Cast \'Cleave\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27984);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27984, 0, 0, 0, 0, 0, 100, 2, 3000, 7000, 13000, 20000, 0, 0, 11, 15654, 64, 0, 0, 0, 0, 5, 30, 1, 0, 15654, 0, 0, 0, 0, 'Dark Rune Stormcaller - In Combat - Cast \'Shadow Word: Pain\' (Normal Dungeon)'),
(27984, 0, 1, 0, 0, 0, 100, 4, 3000, 7000, 13000, 20000, 0, 0, 11, 59864, 64, 0, 0, 0, 0, 5, 30, 1, 0, 59864, 0, 0, 0, 0, 'Dark Rune Stormcaller - In Combat - Cast \'Shadow Word: Pain\' (Heroic Dungeon)'),
(27984, 0, 2, 0, 0, 0, 100, 2, 2000, 4000, 3000, 6000, 0, 0, 11, 12167, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Stormcaller - In Combat - Cast \'Lightning Bolt\' (Normal Dungeon)'),
(27984, 0, 3, 0, 0, 0, 100, 4, 2000, 4000, 3000, 6000, 0, 0, 11, 59863, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Stormcaller - In Combat - Cast \'Lightning Bolt\' (Heroic Dungeon)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27985);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27985, 0, 0, 0, 0, 0, 100, 0, 8000, 14000, 13000, 22000, 0, 0, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Golem Custodian - In Combat - Cast \'Crush Armor\''),
(27985, 0, 1, 0, 0, 0, 100, 2, 4000, 7000, 8000, 13000, 0, 0, 11, 12734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Golem Custodian - In Combat - Cast \'Ground Smash\' (Normal Dungeon)'),
(27985, 0, 2, 0, 0, 0, 100, 4, 4000, 7000, 8000, 13000, 0, 0, 11, 59865, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Golem Custodian - In Combat - Cast \'Ground Smash\' (Heroic Dungeon)');
