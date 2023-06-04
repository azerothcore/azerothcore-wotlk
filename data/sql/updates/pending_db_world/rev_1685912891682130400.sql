--
-- Creature entry 20287, Zaxxis Ambusher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20287;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20287);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20287, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 85, 0, 0, 0, 0, 0, 0, 0, 'Zaxxis Ambusher - On Just Summoned - Start Attacking');

-- Send script event
DELETE FROM `event_scripts` WHERE `id`=13052;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(13052, 2, 10, 20287, 180000, 0, 2547.08, 3982.24, 131.39, 2.01),
(13052, 20, 10, 20287, 180000, 0, 2537.70, 3975.96, 130.40, 1.58),
(13052, 35, 10, 20287, 180000, 0, 2506.46, 4008.93, 133.80, 6.19),
(13052, 50, 10, 20287, 180000, 0, 2537.30, 4027.11, 135.50, 4.30);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 35282) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20243) AND (`ConditionValue2` = 13) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 35282, 0, 0, 29, 0, 20243, 13, 0, 0, 0, 0, '', 'Shocks the Scrapped Fel Reaver\'s heart into a state that it can be salvaged.');
