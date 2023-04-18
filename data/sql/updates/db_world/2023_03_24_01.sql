-- DB update 2023_03_24_00 -> 2023_03_24_01
SET @ENTRY := 18869;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 34302, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On respawn - Self: Cast spell Coalesce (34302) with flags interrupt previous on Self'),
(@ENTRY, 0, 1, 0, 6, 0, 8, 1, 0, 0, 0, 0, 11, 36463, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On death - Self: Cast spell Unstable Rift (36463) with flags interrupt previous on Self');
