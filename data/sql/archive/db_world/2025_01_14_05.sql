-- DB update 2025_01_14_04 -> 2025_01_14_05
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256,  `AIName` = 'SmartAI' WHERE `entry` = 24374;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24374) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24374, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 12000, 24000, 0, 0, 11, 43673, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - In Combat - Cast \'Mighty Blow\''),
(24374, 0, 1, 0, 2, 0, 100, 1, 0, 20, 1000, 1000, 0, 0, 11, 28747, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - Between 0-20% Health - Cast \'Frenzy\' (No Repeat)');
