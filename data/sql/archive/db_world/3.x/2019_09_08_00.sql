-- DB update 2019_09_06_00 -> 2019_09_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_06_00 2019_09_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1565907440369912865'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1565907440369912865');

-- "Small Proto-Drake Egg" not needed anymore, as those will be spawned via SAI
DELETE FROM `gameobject` WHERE `id` = 192538;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (30461,30462);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (3046100,3046101,3046200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
-- Veranus
(30461,0,0,1,54,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Just Summoned - Set Active On'),
(30461,0,1,2,61,0,100,0,0,0,0,0,0,80,3046100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - Linked - Call Action List'),
(30461,0,2,0,61,0,100,0,0,0,0,0,0,53,1,3046100,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - Linked - Start Waypoint'),
(30461,0,3,0,58,0,100,0,1,3046100,0,0,0,80,3046101,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Waypoint Finished - Call Action List'),
(30461,0,4,0,58,0,100,0,1,3046101,0,0,0,46,200,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Waypoint Finished - Move Forward 200 Yards'),

(3046100,9,0,0,0,0,100,0,0,0,0,0,0,50,192538,55,0,0,0,0,8,0,0,0,0,7081.58,-918.08,1067.29,3.54701,'Veranus - On Script - Summon ''Small Proto-Drake Egg'''),
(3046100,9,1,0,0,0,100,0,0,0,0,0,0,50,192538,55,0,0,0,0,8,0,0,0,0,7079.2,-911.72,1067.24,5.23955,'Veranus - On Script - Summon ''Small Proto-Drake Egg'''),
(3046100,9,2,0,0,0,100,0,0,0,0,0,0,50,192538,55,0,0,0,0,8,0,0,0,0,7081.99,-905.079,1067.04,1.45786,'Veranus - On Script - Summon ''Small Proto-Drake Egg'''),
(3046100,9,3,0,0,0,100,0,0,0,0,0,0,50,192538,55,0,0,0,0,8,0,0,0,0,7085.83,-913.035,1067.58,5.67152,'Veranus - On Script - Summon ''Small Proto-Drake Egg'''),
(3046100,9,4,0,0,0,100,0,0,0,0,0,0,50,192538,55,0,0,0,0,8,0,0,0,0,7091.09,-907.548,1067.24,2.36273,'Veranus - On Script - Summon ''Small Proto-Drake Egg'''),

(3046101,9,0,0,0,0,100,0,0,0,0,0,0,207,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Set Hover Off'),
(3046101,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Say Line 0'),
(3046101,9,2,0,0,0,100,0,0,0,0,0,0,5,447,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Play Emote ''ONESHOT_FLY_SIT_GROUND_DOWN'''),
(3046101,9,3,0,0,0,100,0,10000,10000,0,0,0,12,30462,3,40000,0,0,0,8,0,0,0,0,7072.59,-906.93,1120.29,5.84493,'Veranus - On Script - Summon Creature ''Thorim'''),
(3046101,9,4,0,0,0,100,0,0,0,0,0,0,41,40000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Force Despawn'),
(3046101,9,5,0,0,0,100,0,0,0,0,0,0,33,30461,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Veranus - On Script - Quest Credit ''Territorial Trespass'''),
(3046101,9,6,0,0,0,100,0,16000,16000,0,0,0,207,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Set Hover On'),
(3046101,9,7,0,0,0,100,0,1000,1000,0,0,0,53,1,3046101,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Start Waypoint'),
(3046101,9,8,0,0,0,100,0,0,0,0,0,0,5,448,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Play Emote ''ONESHOT_FLY_SIT_GROUND_UP'''),

-- Thorim
(30462,0,0,0,54,0,100,0,0,0,0,0,0,80,3046200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Just Summoned - Run Script'),

(3046200,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Set Active On'),
(3046200,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 0'),
(3046200,9,2,0,0,0,100,0,0,0,0,0,0,11,43671,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Thorim - On Script - Cast ''Ride Vehicle'''),
(3046200,9,3,0,0,0,100,0,10000,10000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 1'),
(3046200,9,4,0,0,0,100,0,5000,5000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 2');

DELETE FROM `waypoints` WHERE `entry` IN (30461,3046100,3046101);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(3046100,1,7081.55,-907.867,1067.18,'Veranus - WP1'),
(3046101,1,7110.2,-916.508,1100.75,'Veranus - WP2');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
