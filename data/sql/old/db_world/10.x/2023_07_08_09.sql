-- DB update 2023_07_08_08 -> 2023_07_08_09
--
-- Creature entry 20287, Zaxxis Ambusher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20287;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20287);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20287, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 85, 0, 0, 0, 0, 0, 0, 0, 'Zaxxis Ambusher - On Just Summoned - Start Attacking');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 35282) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20243) AND (`ConditionValue2` = 13) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 35282, 0, 0, 29, 0, 20243, 13, 0, 0, 0, 0, '', 'Shocks the Scrapped Fel Reaver\'s heart into a state that it can be salvaged.');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20243) AND (`source_type` = 0) AND (`id` IN (4, 5, 6, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20243, 0, 4, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 0, 12, 20287, 2, 180000, 1, 0, 0, 8, 0, 0, 0, 0, 2587.87, 3952.51, 136.37, 2.38, 'Scrapped Fel Reaver - In Combat - Summon Creature \'Zaxxis Ambusher\''),
(20243, 0, 5, 0, 0, 0, 100, 0, 17000, 17000, 45000, 45000, 0, 12, 20287, 2, 180000, 1, 0, 0, 8, 0, 0, 0, 0, 2535.75, 3922.99, 135.58, 1.81, 'Scrapped Fel Reaver - In Combat - Summon Creature \'Zaxxis Ambusher\''),
(20243, 0, 6, 0, 0, 0, 100, 0, 32000, 32000, 45000, 45000, 0, 12, 20287, 2, 180000, 1, 0, 0, 8, 0, 0, 0, 0, 2506.46, 4008.93, 133.8, 6.19, 'Scrapped Fel Reaver - In Combat - Summon Creature \'Zaxxis Ambusher\''),
(20243, 0, 7, 0, 0, 0, 100, 0, 60000, 60000, 45000, 45000, 0, 12, 20287, 2, 180000, 1, 0, 0, 8, 0, 0, 0, 0, 2537.3, 4027.11, 135.5, 4.3, 'Scrapped Fel Reaver - In Combat - Summon Creature \'Zaxxis Ambusher\''),
(20243, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 9, 20287, 0, 200, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Just Died - Kill Target'),
(20243, 0, 9, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 9, 20287, 0, 200, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Evade - Kill Target');
