-- DB update 2022_07_23_01 -> 2022_07_24_00
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7453;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7453) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7453, 0, 0, 0, 0, 0, 100, 0, 7000, 11000, 15000, 18000, 0, 11, 15798, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Moontouched Owlbeast - In Combat - Cast \'Moonfire\''),
(7453, 0, 1, 0, 0, 0, 100, 0, 0, 0, 18000, 21000, 0, 11, 12160, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moontouched Owlbeast - In Combat - Cast \'Rejuvenation\'');

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 7453) AND (`Index` IN (0, 1));
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(7453, 0, 15798, 12340),
(7453, 1, 12160, 12340);
