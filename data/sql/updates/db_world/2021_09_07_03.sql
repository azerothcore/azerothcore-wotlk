-- DB update 2021_09_07_02 -> 2021_09_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_07_02 2021_09_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630682164924984301'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630682164924984301');

-- Removed one of the spawns of Razormaw Matriach's Nest because its on the same place as the guid 6245
DELETE FROM `gameobject` WHERE (`id` = 202083) AND (`guid` IN (14999));

-- Added the spawns to the same pool so only 1 can be spawned at the same time
DELETE FROM `pool_template` WHERE `entry` = 374;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (374, 1, 'Razormaw Matriach''s Nest spawns');

DELETE FROM `pool_gameobject` WHERE `guid` IN (6245, 6246, 6247, 6248);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(6245, 374, 0, 'Razormaw Matriach''s Nest spawn 1'),
(6246, 374, 0, 'Razormaw Matriach''s Nest spawn 2'),
(6247, 374, 0, 'Razormaw Matriach''s Nest spawn 3'),
(6248, 374, 0, 'Razormaw Matriach''s Nest spawns 4');

-- Removing the pool and spawn of the guid 14999
DELETE FROM `pool_gameobject` WHERE `guid` = 14999;
DELETE FROM `pool_template` WHERE `entry` = 202482;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_03' WHERE sql_rev = '1630682164924984301';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
