-- DB update 2025_05_29_01 -> 2025_05_30_00

-- Death Knight Champions
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29106) AND (`source_type` = 0) AND (`id` IN (4));

-- Rampaging Abominations
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29115) AND (`source_type` = 0) AND (`id` IN (2));

-- Volatile Ghouls
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29136) AND (`source_type` = 0) AND (`id` IN (1));

-- Scarlet Crusaders
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~134217728 WHERE (`entry` = 28529);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-128705, -128706, -128707, -128708, -128709, -128710, -128711, -128712, -128713));

-- Havenshire Colts
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-129243, -129245, -129246, -129248, -129249, -129251));

-- Havenshire Mares
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-129230, -129234, -129235, -129236));

-- Havenshire Stallions
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -129210) AND (`source_type` = 0) AND (`id` IN (5));
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-129208, -129214)) AND (`source_type` = 0) AND (`id` IN (3));

-- Set Active on Kitrik
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28683;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28683) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28683, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stable Master Kitrik - On Reset - Set Active On');
