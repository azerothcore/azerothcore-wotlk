-- DB update 2024_11_07_06 -> 2024_11_08_00
-- Arzeth the Merciless
UPDATE `creature` SET `position_x`=-659.412, `position_y`=4799.82, `position_z`=49.0951 WHERE `guid` = 69051 AND `id1` = 19354;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 19354 AND `id` = 7;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19354, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 690510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - On Respawn - Start Path ');
