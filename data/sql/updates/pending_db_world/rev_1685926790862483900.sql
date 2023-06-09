-- Fix GambeObjects 180772 - 180869 - 180874 (Cluster Launcher) --
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (180772, 180869, 180874);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (180772, 180874, 180869);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180772, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\''),
(180869, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\''),
(180874, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\'');
