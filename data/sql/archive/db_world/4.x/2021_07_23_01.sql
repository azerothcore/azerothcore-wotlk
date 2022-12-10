-- DB update 2021_07_23_00 -> 2021_07_23_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_00 2021_07_23_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626790590532118200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626790590532118200');

-- Changed the position of the spawn to match the source. Updates animprogress to 0 because its not a box
UPDATE `gameobject` SET `position_x` = -7194.81, `position_y` = -3753.68, `position_z` = 8.62923, `animprogress` = 0 WHERE (`id` = 175763) AND (`guid` = 17342);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_01' WHERE sql_rev = '1626790590532118200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
