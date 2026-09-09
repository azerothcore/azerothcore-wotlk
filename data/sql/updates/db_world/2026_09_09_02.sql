-- DB update 2026_09_09_01 -> 2026_09_09_02
--
-- Wailing Caverns - Serpentbloom Snake
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 3680;

-- Preserve running speed during random movement (AlwaysRun).
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 3680;
INSERT INTO `creature_template_movement` (`CreatureId`, `Random`) VALUES
(3680, 2);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3680 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3680, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentbloom Snake - On Just Summoned - Start Random Movement (30 Yards) (No Repeat)'),
(3680, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentbloom Snake - On Link - Despawn In 5 Minutes');
