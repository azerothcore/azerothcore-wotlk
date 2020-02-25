INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582663580844407800');

UPDATE `creature_addon` SET `path_id`=0 WHERE `guid` IN (46394, 46416); 
DELETE FROM `waypoint_data` WHERE `id` IN (463940,464160);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 46414; 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(46414,46414,0,0,515,0,0), 
(46414,46394,2,135,515,0,0), 
(46414,46416,3,225,515,0,0);  
