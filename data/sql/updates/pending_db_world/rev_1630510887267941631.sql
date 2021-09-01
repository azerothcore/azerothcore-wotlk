INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630510887267941631');

-- Set the Creature Shadowclaw a patrol route movement
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 2175);
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 2175) AND (`guid` = 37432);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 37432);

-- Add new routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(37432, 374320, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE (`id` = 374320);

-- Waypoint route 1 (GUID: 37432)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(374320,1,6594.53,312.86,28.24,0,0,0,0,100,0), 
(374320,2,6612.45,337.54,29.08,0,0,0,0,100,0),
(374320,3,6622.91,343.46,27.86,0,0,0,0,100,0), 
(374320,4,6667.9,343.52,26.06,0,0,0,0,100,0), 
(374320,5,6727.573,375.80,25.405,0,0,0,0,100,0), 
(374320,6,6751.12,397.45,23.229,0,0,0,0,100,0), 
(374320,7,6842.26,370.716,16.940,0,0,0,0,100,0), 
(374320,8,6818.17,324.642,18.62,0,0,0,0,100,0), 
(374320,9,6756.632,288.137,22.273,0,0,0,0,100,0), 
(374320,10,6699.87,290.51,29.964,0,0,0,0,100,0), 
(374320,11,665,302.50,32.440,0,0,0,0,100,0), 
(374320,12,6610.96,318.83,28.249,0,0,0,0,100,0),
(374320,13,6564.23,303.17,31.45,0,0,0,0,100,0);

-- Added stealth while he moves: He patrols around while stealthed. Your best bet is to hunt in the area and hope he aggros to you.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2175) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2175, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 42866, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowclaw - On Reset - Cast \'Stealth\'');

