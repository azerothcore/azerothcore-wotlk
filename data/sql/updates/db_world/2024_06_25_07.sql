-- DB update 2024_06_25_06 -> 2024_06_25_07
-- Kirin'Var Apprentice
UPDATE `creature_template_addon` SET `auras` = '33900' WHERE (`entry` = 20409);
UPDATE `creature_addon` SET `auras` = '33900' WHERE `guid` IN (72371, 72374, 72375, 72377, 72378, 72379);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20409);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20409, 0, 0, 0, 9, 0, 100, 0, 0, 0, 0, 0, 10, 35, 11, 36099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin\'Var Apprentice - Within 10-35 Range - Cast \'Throw Hammer\'');
