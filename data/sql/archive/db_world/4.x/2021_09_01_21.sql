-- DB update 2021_09_01_20 -> 2021_09_01_21
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_20';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_20 2021_09_01_21 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630228897555898489'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630228897555898489');

-- Set the Creature Lord Xiz a patrol route movement
UPDATE `creature` SET `MovementType` = 2  WHERE (`id` = 17701) AND (`guid` = 63448);
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 17701);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 63448);

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(63448, 634480, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` = 634480;

INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- Waypoint route 1 (GUID: 63448)
(634480,1,-2255.01,-12318.75,57.29,0,0,0,0,100,0),
(634480,2,-2205.076,-12318.180,54.73,0,0,0,0,100,0),
(634480,3,-2182.07,-12321.914,55.31,0,0,0,0,100,0),
(634480,4,-2205.076,-12318.180,54.73,0,0,0,0,100,0),
(634480,5,-2255.01,-12318.75,57.29,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_21' WHERE sql_rev = '1630228897555898489';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
