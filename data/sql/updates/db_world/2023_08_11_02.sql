-- DB update 2023_08_11_01 -> 2023_08_11_02
 -- Infected Wildkin smart ai
SET @ENTRY := 17322;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 0, 0, 11, 31282, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infected Wildkin - In Combat - Cast \'Infected Wound\'');


