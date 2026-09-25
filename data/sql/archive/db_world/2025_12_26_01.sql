-- DB update 2025_12_26_00 -> 2025_12_26_01
-- Thaurissan Relic smart ai
SET @ENTRY := 153556;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 215, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7442.29, -2257.15, 0, 0, 'On loot state changed to GO_ACTIVATED - Load grid (-7442.29, -2257.15)'),
(@ENTRY, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 4603, 8887, 0, 0, 0, 0, 0, 'On loot state changed to GO_ACTIVATED - Creature A tormented voice (8887) with guid 4603 (fetching): Talk 0 to invoker');
