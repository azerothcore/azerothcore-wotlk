-- DB update 2021_07_23_17 -> 2021_07_23_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_17 2021_07_23_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626782944130753700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626782944130753700');

-- Changed the spawn point of Spellmaw closer to the ground and added patrolling around
UPDATE `creature` SET `position_x` = 6247.134, `position_y` = -4412.64, `position_z` = 687.228, `orientation` = 4.67879, `wander_distance` = 20,`MovementType` = 1  WHERE (`id` = 10662) AND (`guid` = 42265);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_18' WHERE sql_rev = '1626782944130753700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
