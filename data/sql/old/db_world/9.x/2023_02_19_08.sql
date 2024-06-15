-- DB update 2023_02_19_07 -> 2023_02_19_08
-- 
DELETE FROM `gameobject_queststarter` WHERE (`quest` = 2954) AND (`id` IN (142343));
INSERT INTO `gameobject_queststarter` (`id`, `quest`) VALUES
(142343, 2954);

DELETE FROM `creature_queststarter` WHERE `quest` = 2954;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 142343) AND (`source_type` = 1) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(142343, 1, 2, 0, 19, 0, 100, 0, 2954, 0, 0, 0, 0, 80, 14234300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Uldum Pedestal - On Quest \'The Stone Watcher\' Taken - Run Script');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 142343);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 142343, 1, 0, 29, 1, 7918, 10, 0, 1, 0, 0, '', 'Only summon Stone Watcher of Norgannon if there isn\'t one already spawned'),
(22, 2, 142343, 1, 0, 29, 1, 7918, 10, 0, 1, 0, 0, '', 'Only summon Stone Watcher of Norgannon if there isn\'t one already spawned'),
(22, 3, 142343, 1, 0, 29, 1, 7918, 10, 0, 1, 0, 0, '', 'Only summon Stone Watcher of Norgannon if there isn\'t one already spawned');
