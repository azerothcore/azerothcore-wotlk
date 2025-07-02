-- DB update 2025_07_01_03 -> 2025_07_02_00

-- Remove Mount from creature_template_addon
UPDATE `creature_template_addon` SET `mount` = 0 WHERE (`entry` = 29175);

-- Edit SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29175;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29175);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29175, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 14338, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Tirion Fordring - On Just Summoned - Mount To Model 14338'),
(29175, 0, 1, 2, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Tirion Fordring - On Path 0 Finished - Dismount'),
(29175, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.69297, 'Highlord Tirion Fordring - On Path 0 Finished - Set Orientation 1.69297');
