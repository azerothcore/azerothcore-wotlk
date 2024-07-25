--
DELETE FROM `waypoints` where `entry` = 2195800;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21958;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21958) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21958, 0, 0, 0, 75, 0, 100, 0, 0, 21212, 2, 1000, 0, 11, 38044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Elemental - On Distance to Vashj - Cast Spell Surge'),
(21958, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Elemental - On Aggro - Set In Combat With Zone');
