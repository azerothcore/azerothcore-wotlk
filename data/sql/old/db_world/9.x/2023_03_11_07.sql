-- DB update 2023_03_11_06 -> 2023_03_11_07
-- Steam Pump Overseer
UPDATE `creature_template_addon` SET `auras` = '6961' WHERE `entry` = 18340;
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64 WHERE `entry` = 18340;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18340);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18340, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - On Just Summoned - Say Line 0'),
(18340, 0, 1, 0, 2, 0, 100, 512, 0, 90, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-90% Health - Cast \'Toughen\' I'),
(18340, 0, 2, 0, 2, 0, 100, 512, 0, 80, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-80% Health - Cast \'Toughen\' II'),
(18340, 0, 3, 0, 2, 0, 100, 512, 0, 70, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-70% Health - Cast \'Toughen\' III'),
(18340, 0, 4, 0, 2, 0, 100, 512, 0, 60, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-60% Health - Cast \'Toughen\' IV'),
(18340, 0, 5, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-50% Health - Cast \'Toughen\' V'),
(18340, 0, 6, 0, 2, 0, 100, 512, 0, 40, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-40% Health - Cast \'Toughen\' VI'),
(18340, 0, 7, 0, 2, 0, 100, 512, 0, 30, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-30% Health - Cast \'Toughen\' VII'),
(18340, 0, 8, 0, 2, 0, 100, 512, 0, 20, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-20% Health - Cast \'Toughen\' VIII'),
(18340, 0, 9, 0, 2, 0, 100, 512, 0, 10, 0, 0, 0, 11, 33962, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 0-10% Health - Cast \'Toughen\' IX');
