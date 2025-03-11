-- DB update 2024_11_11_00 -> 2024_11_11_01
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 43734;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43734, 0, 0, 31, 0, 3, 23817, 0, 0, 0, 0, '', 'Hatch Eggs can only hit Dragonhawk Egg');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 23817;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23817) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23817, 0, 0, 0, 8, 0, 100, 0, 42471, 0, 0, 0, 0, 0, 11, 42493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonhawk Egg - On Spellhit \'Hatch Eggs\' - Cast \'Summon Dragonhawk Hatchling\''),
(23817, 0, 1, 0, 8, 0, 100, 0, 43734, 0, 0, 0, 0, 0, 11, 42493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonhawk Egg - On Spellhit \'Hatch Eggs\' - Cast \'Summon Dragonhawk Hatchling\'');

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 23598;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Flight`) VALUES
(23598, 1, 1);
