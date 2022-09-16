-- DB update 2019_07_09_00 -> 2019_07_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_09_00 2019_07_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561816769087112416'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561816769087112416');

-- Only one game object "Saronite", pool entry is not needed
DELETE FROM `pool_gameobject` WHERE `pool_entry` = 5217;

-- Only one creature "Hematos" (8976), pool entry is not needed
DELETE FROM `pool_creature` WHERE `pool_entry` = 1047;

-- Add missing Saronite nodes to pool template
DELETE FROM `pool_template` WHERE `entry` IN (5450,5506,5608,5517);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`)
VALUES
(5450,1,'Icecrown 189980, node 3'),
(5506,1,'Icecrown 189980, node 59'),
(5608,1,'Icecrown 189980, node 161'),
(5517,1,'Icecrown 189981, node 70');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
