-- DB update 2022_02_22_02 -> 2022_02_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_22_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_22_02 2022_02_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644689254263193400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644689254263193400');

UPDATE `creature_template` SET `lootid`=2673 WHERE `entry`=2673;

DELETE FROM `creature_loot_template` WHERE `entry`=2673;
INSERT INTO `creature_loot_template` VALUES
(2673,2592,0,0,0,1,1,1,1,'Training Dummy'),
(2673,2841,0,0,0,1,1,1,1,'Training Dummy'),
(2673,4359,0,0,0,1,1,1,2,'Training Dummy'),
(2673,4363,0,0,0,1,1,1,1,'Training Dummy'),
(2673,7191,0,20,0,1,0,1,1,'Training Dummy');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_23_00' WHERE sql_rev = '1644689254263193400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
