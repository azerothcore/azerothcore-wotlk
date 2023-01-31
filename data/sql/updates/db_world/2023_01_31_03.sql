-- DB update 2023_01_31_02 -> 2023_01_31_03
-- Fix comments as well
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18880);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18880, 0, 0, 0, 9, 0, 100, 0, 0, 20, 7000, 11000, 0, 11, 35334, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Ray - Within 0-20 Range - Cast \'Nether Shock\''),
(18880, 0, 1, 0, 9, 0, 100, 0, 0, 15, 6000, 9000, 0, 11, 36659, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Ray - Within 0-15 Range - Cast \'Tail Sting\''),
(18880, 0, 2, 0, 9, 0, 100, 0, 0, 10, 11000, 15000, 0, 11, 17008, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Ray - Within 0-10 Range - Cast \'Drain Mana\''),
(18880, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Ray - On Reset - Set Mana To 0');

UPDATE `creature_template` SET `unit_flags2`=`unit_flags2`&~2048 WHERE (`entry` = 18880);
