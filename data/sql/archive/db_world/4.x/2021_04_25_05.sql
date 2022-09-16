-- DB update 2021_04_25_04 -> 2021_04_25_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_25_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_25_04 2021_04_25_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618611183125814200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618611183125814200');

UPDATE `gameobject` SET `position_x`=-12025.065, `position_y`=537.556, `position_z`=0, `orientation`=3.03687 WHERE `guid`=64761;

UPDATE `gameobject` SET `position_x`=-12025.065, `position_y`=537.556, `position_z`=0, `orientation`=3.03687 WHERE `guid`=47407;

UPDATE `gameobject` SET `position_x`=-11993.8, `position_y`=649.109, `position_z`=0, `orientation`=-2.16421 WHERE `guid`=47420;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
