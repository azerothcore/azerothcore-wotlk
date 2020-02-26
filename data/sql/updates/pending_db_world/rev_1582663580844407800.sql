INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582663580844407800');

-- Set movement type to stay in one place
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (46414, 46416);

-- Deactivate paths for creature 46414 and 46416 
UPDATE `creature_addon` SET `path_id`= 0 WHERE `guid` IN (46414, 46416); 

-- Take over waypoints from creature 46414 to creature 46394
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
SELECT 463940, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid` FROM `waypoint_data` WHERE `id` = 464140;

-- Delete waypoints for creature 46414
DELETE FROM `waypoint_data` WHERE `id` IN(464140, 464160);

-- Create the formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 46394; 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(46394,46394,0,0,515,0,0), 
(46394,46414,2,135,515,0,0), 
(46394,46416,3,225,515,0,0); 

/* Leader 46414 1st formation (Just until the PR is finished)
(46394,46394,0,0,515,0,0), 
(46394,46414,2,135,515,0,0), 
(46394,46416,3,225,515,0,0);  
*/
