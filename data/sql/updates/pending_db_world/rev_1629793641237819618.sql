INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629793641237819618');

-- Set the Creature Swiftmane (5831) a patrol route movement
UPDATE `creature` SET `MovementType` = 2  WHERE (`id` = 5831) AND (`guid` = 20433);
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 5831);

-- Delete all waypoints routes and add new one
DELETE FROM `waypoints` WHERE `entry` = 5831;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
-- Waypoint route 1 (GUID: 20433)
(5831,1,-668.03,-3536.53,92.14,'Swiftmane'),
(5831,2,-616.04,-3500.51,94.52,'Swiftmane'),
(5831,3,-560.47,-3482.41,91.84,'Swiftmane'),
(5831,4,-500.34,-3476.90,94.87,'Swiftmane'),
(5831,5,-475.50,-3486.94,92.70,'Swiftmane'),
(5831,6,-464.66,-3512.42,95.44,'Swiftmane'),
(5831,7,-480.57,-3555.76,91.66,'Swiftmane'),
(5831,8,-520.76,-3582.95,93.10,'Swiftmane'),
(5831,9,-568.98,-3603.25,92.10,'Swiftmane'),
(5831,10,-650.82,-3609.06,92.96,'Swiftmane'),
(5831,11,-686.02,-3593.70,91.82,'Swiftmane');

-- Add action for her to run in the route
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5831;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5831) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5831, 0, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 5831, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Swiftmane - Out of Combat - Start Waypoint');

