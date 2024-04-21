-- DB update 2021_12_13_00 -> 2021_12_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_13_00 2021_12_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639016687135997067'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639016687135997067');

-- SAI for Solanin <Bag Vendor>
UPDATE `creature_template` SET `AIName`="SmartAI", `ScriptName`='' WHERE `entry`=18947;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18947 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1894700,1894701,1894702) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18947, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 53, 0, 18947, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - OOC - Load path Repeating once'),
(18947, 0, 1, 2, 40, 0, 100, 0, 1, 18947, 0, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 1 - Pause Path 6 sec'),
(18947, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 1894700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 1 - Run Script'),
(18947, 0, 3, 4, 40, 0, 100, 0, 2, 18947, 0, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 2 - Pause Path 6 sec'),
(18947, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 1894700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 2 - Run Script'),
(18947, 0, 5, 0, 40, 0, 100, 0, 5, 18947, 0, 0, 54, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 4 - Pause Path 12 sec'),
(18947, 0, 6, 7, 40, 0, 100, 0, 6, 18947, 0, 0, 54, 14000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 6 - Pause Path 14 sec'),
(18947, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 1894701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 6 - Run Script'),
(18947, 0, 8, 9, 40, 0, 100, 0, 7, 18947, 0, 0, 54, 175000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 7 - Pause Path 175 sec'),
(18947, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 1894702, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Reach Waypoint 7 - Run Script'),
(1894700, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Script - Emote Kneel'),
(1894701, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 3.00197, 'Solanin <Bag Vendor> - Script - Set heading'),
(1894701, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Script - Say Text 0'),
(1894701, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solanin <Bag Vendor> - Script - Say Text 1'),
(1894702, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.49582, 'Solanin <Bag Vendor> - Script - Set heading');
-- SAI Path for Solanin <Bag Vendor>
DELETE FROM `waypoints` WHERE `entry`=18947;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(18947,1,9311.077,-6546.257,34.846924,0,0, 'Solanin <Bag Vendor>'),
(18947,2,9305.104,-6541.021,34.835205,0,0, 'Solanin <Bag Vendor>'),
(18947,3,9301.6,-6547.752,34.710205,0,0, 'Solanin <Bag Vendor>'),
(18947,4,9301.036,-6550.4854,34.710205,0,0, 'Solanin <Bag Vendor>'),
(18947,5,9300,-6554.6353,33.846703,0,0, 'Solanin <Bag Vendor>'),
(18947,6,9311.535,-6549.8223,34.948242,0,0, 'Solanin <Bag Vendor>'),
(18947,7,9309.143,-6555.4087,34.67163,0,0, 'Solanin <Bag Vendor>');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_13_01' WHERE sql_rev = '1639016687135997067';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
