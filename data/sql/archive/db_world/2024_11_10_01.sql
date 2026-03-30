-- DB update 2024_11_10_00 -> 2024_11_10_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 24143;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24143) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24143, 0, 0, 0, 0, 0, 100, 0, 30000, 50000, 30000, 50000, 0, 0, 11, 43290, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - In Combat - Cast \'Lynx Flurry\''),
(24143, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 4000, 4000, 0, 0, 11, 43243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - In Combat - Cast \'Shred Armor\''),
(24143, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - On Reset - Set Invincibility Hp 1'),
(24143, 0, 3, 0, 2, 0, 100, 0, 20, 20, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirit of the Lynx - Between 20-20% Health - Do Action ID 0');
