-- DB update 2025_05_27_02 -> 2025_05_29_00
-- Adds SAI to the missing NPCs and SAI Event to execute the Timed Actionlist
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` IN (23853, 23852, 23854, 23855, 23845);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23853, 23852, 23854, 23855, 23845) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23845, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2384500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - On Respawn - Run Script'),
(23855, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2385500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Chief Thunder-Skins Controller - On Respawn - Run Script'),
(23854, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2385400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Sig Controller - On Respawn - Run Script'),
(23852, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2385200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Mai\'Kyl Controller - On Respawn - Run Script'),
(23853, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2385300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - On Respawn - Run Script');
