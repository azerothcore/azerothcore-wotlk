-- DB update 2024_12_29_04 -> 2024_12_30_00
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28802 AND `id` = 4 AND `source_type` = 0;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28802, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 142, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Servant of Drakuru - On Update Entry - Set Health 100%');

UPDATE `smart_scripts` SET `link` = 4 WHERE `entryorguid` = 28802 AND `id` = 2 AND `source_type` = 0 AND `link` = 0;
