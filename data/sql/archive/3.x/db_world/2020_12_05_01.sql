-- DB update 2020_12_05_00 -> 2020_12_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_05_00 2020_12_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606571992509460569'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

DELETE FROM `creature_formations` WHERE `memberGUID` IN (9203, 9204, 9205) AND `leaderGUID` = 9203;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(9203, 9203, 0, 0, 2, 0, 0),
(9203, 9204, 3, 45, 2, 0, 0),
(9203, 9205, 3, 315, 2, 0, 0);

DELETE FROM `creature_addon` WHERE guid IN (9204,9205);
DELETE FROM `waypoint_data` WHERE id IN (92040,92050);
UPDATE `creature` SET `MovementType`=0, `wander_distance`=0 WHERE `id` IN (2477,7170);
UPDATE `creature_template` SET `MovementType`=0 WHERE `entry` IN (2477,7170);
UPDATE `creature_template` SET `Speed_Walk`=1.47, `Speed_Run`=1.14286 WHERE `entry` IN (2478);
UPDATE `creature_template` SET `Speed_Walk`=1.48, `Speed_Run`=1.14286 WHERE `entry` IN (2477,7170);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
