-- DB update 2024_05_09_00 -> 2024_05_11_00
--
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (180690, 180691);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (180690, 180691));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180690, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 106, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Large Scarab Coffer - On Gameobject State Changed - Remove Gameobject Flags Locked'),
(180691, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 106, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarab Coffer - On Gameobject State Changed - Remove Gameobject Flags Locked');
