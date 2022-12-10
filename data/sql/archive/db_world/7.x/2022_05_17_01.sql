-- DB update 2022_05_17_00 -> 2022_05_17_01
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10376;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10376);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10376, 0, 0, 0, 37, 0, 85, 512, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On AI initialize - None: Despawn in 0.5 s'),
(10376, 0, 1, 0, 6, 0, 100, 514, 0, 0, 0, 0, 0, 11, 16103, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystal Fang - On Death - Cast Spell Summon Spire Spiderling (16103)');
