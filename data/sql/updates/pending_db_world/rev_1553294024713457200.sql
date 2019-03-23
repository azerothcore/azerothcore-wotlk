INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553294024713457200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7572;

DELETE FROM `smart_scripts` WHERE `entryorguid`=7572;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (7572, 0, 0, 2, 62, 0, 100, 1, 842, 0, 0, 0, 0, 26, 2784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 0 Selected - Quest Credit \'Fall From Grace\''),
(7572, 0, 1, 3, 62, 0, 100, 1, 881, 0, 0, 0, 0, 26, 2801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 1 Selected - Quest Credit \'A Tale of Sorrow\''),
(7572, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 0 Selected - Close Gossip'),
(7572, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 1 Selected - Close Gossip'),
(7572, 0, 4, 5, 62, 0, 100, 0, 840, 2, 0, 0, 0, 11, 11024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option Selected - Cast Self Call of Thund'),
(7572, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option Selected - Close Gossip');
