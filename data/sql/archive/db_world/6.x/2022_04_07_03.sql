-- DB update 2022_04_07_02 -> 2022_04_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_07_02 2022_04_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648521257247923500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648521257247923500');

-- Watcher Cutford
DELETE FROM `waypoints` WHERE `entry` = 1436 AND `pointid` in (3,4,5,6,7,8,9,10,11,12,61);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(1436,3,-10558.387,-1141.187,30.069,0,0,'Watcher Cutford'),
(1436,4,-10559.6,-1132.51,30.067,0,0,'Watcher Cutford'),
(1436,5,-10564.762,-1124.821,30.068,0,0,'Watcher Cutford'),
(1436,6,-10574.529,-1125.063,29.168,0,0,'Watcher Cutford'),
(1436,7,-10575.464,-1121.384,30.069,0,0,'Watcher Cutford'),
(1436,8,-10575.654,-1107.854,30.07,0,0,'Watcher Cutford'),
(1436,9,-10558.476,-1105.974,30.07,0,0,'Watcher Cutford'),
(1436,10,-10555.148,-1105.574,31.429,0,0,'Watcher Cutford'),
(1436,11,-10553.534,-1105.48,31.429,0,0,'Watcher Cutford'),
(1436,12,-10552.769,-1106.959,31.429,0,0,'Watcher Cutford'),
(1436,61,-10930.378,-386.031,40.059,1.0014,1000,'Watcher Cutford');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1436 AND `source_type` = 0 and `id` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1436,0,9,0,40,0,100,0,61,1436,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.0014,'Watcher Cutford - On Waypoint 61 Reached - Set Orientation');

-- Stitches
DELETE FROM `smart_scripts` WHERE `entryorguid` = 412 AND `source_type` = 0  and `id` in (2,3,17,44,45,46);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(412,0,2,46,61,0,100,0,0,0,0,0,0,62,0,0,0,0,0,0,1,0,0,0,0,-10290.2,72.7811,38.8811,4.8015,'Stitches - On Respawn - Teleport'),
(412,0,3,0,1,1,100,1,5000,5000,0,0,0,53,1,412,0,0,0,2,1,0,0,0,0,0,0,0,0,'Stitches - OOC (No Repeat) - Start Waypoint (Phase 1)'),  -- Bug workaround using phasing.  
(412,0,17,44,40,0,100,0,91,412,0,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stitches - On Waypoint 91 Reached - Stop Waypoint'),
(412,0,44,45,61,0,100,0,0,0,0,0,0,89,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stitches - Linked - Start Random Movement'),
(412,0,45,0,61,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stitches - Linked - Event Phase 2'),
(412,0,46,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stitches - Linked - Event Phase 1');

DELETE FROM `waypoints` WHERE `entry` = 412 AND `pointid` in (90,91);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(412,90,-10553.888,-1185.983,27.936,0,0,'Stitches Event'),
(412,91,-10563.188,-1177.061,28.084,4.9437,0,'Stitches Event'); -- Better end event location in front of fountain where he waits/patrols for event to end.

-- Watcher Corwin and Sarys
UPDATE creature SET `spawntimesecs` = 1200 WHERE `guid` in (6127,6133); -- Once these two die we don't need to see them again until the next Stitches event.

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_07_03' WHERE sql_rev = '1648521257247923500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
