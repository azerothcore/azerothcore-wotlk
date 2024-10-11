-- DB update 2021_08_17_02 -> 2021_08_17_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_17_02 2021_08_17_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628955615714597262'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628955615714597262');

-- Shift Silvermane Stalker spawn slightly to avoid tree
UPDATE `creature` SET `position_x` = -108.08, `position_y` = -3529.83, `position_z` = 118.49  WHERE `id` = 2926 AND `guid` = 93058;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_17_03' WHERE sql_rev = '1628955615714597262';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
