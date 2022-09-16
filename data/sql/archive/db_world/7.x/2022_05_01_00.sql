-- DB update 2022_04_28_00 -> 2022_05_01_00
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14347;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14347) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14347, 0, 2, 0, 20, 0, 100, 0, 7786, 0, 0, 0, 0, 12, 14435, 6, 3600000, 0, 0, 0, 8, 0, 0, 0, 0, -6241.77, 1717.14, 4.25042, 0.680879, 'Highlord Demitrian - On Quest Thunderaan the Windseeker Finished - Summon Creature Prince Thunderaan at XYZO');
