-- DB update 2025_01_16_03 -> 2025_01_16_04

-- Bloodscalp Witch Doctor SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 660;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(660, 0, 0, 0, 0, 0, 100, 1, 8000, 12000, 0, 0, 0, 0, 11, 8376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Witch Doctor - In Combat - Cast \'Earthgrab Totem\' (No Repeat)'),
(660, 0, 1, 0, 2, 0, 100, 513, 0, 30, 0, 0, 0, 0, 11, 8599, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Witch Doctor - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(660, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Witch Doctor - Between 0-50% Health - Cast \'Healing Ward\' (No Repeat)');
