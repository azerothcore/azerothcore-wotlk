-- Shattrath Daily Normal/Heroic holograms
UPDATE `creature_template` SET `ScriptName` = 'npc_shattrath_daily_quest' WHERE `entry` IN (24410,24854);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24369;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24369);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24369, 0, 0, 1, 1, 0, 100, 1, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 79464, 24854, 0, 0, 0, 0, 0, 0, 'Wind Trader Zhareem - Out of Combat - Do Action ID 1 (No Repeat)'),
(24369, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 79462, 24410, 0, 0, 0, 0, 0, 0, 'Wind Trader Zhareem - Out of Combat - Do Action ID 1 (No Repeat)'),
(24369, 0, 2, 3, 101, 0, 100, 0, 1, 30, 60000, 60000, 60000, 0, 223, 1, 0, 0, 0, 0, 0, 10, 79464, 24854, 0, 0, 0, 0, 0, 0, 'Wind Trader Zhareem - On 1 or More Players in Range - Do Action ID 1'),
(24369, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 79462, 24410, 0, 0, 0, 0, 0, 0, 'Wind Trader Zhareem - On 1 or More Players in Range - Do Action ID 1');
