-- DB update 2021_09_01_03 -> 2021_09_01_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_03 2021_09_01_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629983088640886216'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629983088640886216');

-- Added roaming movement to Risen Creeper
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16300) AND (`guid` IN (82122, 82123, 82124, 82130, 82713));
-- Added roaming movement to Dreadbone Skeleton
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16303) AND (`guid` IN (82125, 82127, 82131, 82450, 82822, 82823, 82826, 82827, 82841, 82864, 82899, 82932));
-- Added roaming movement to Deathcage Scryer
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16307) AND (`guid` IN (82126, 82129));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_04' WHERE sql_rev = '1629983088640886216';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
