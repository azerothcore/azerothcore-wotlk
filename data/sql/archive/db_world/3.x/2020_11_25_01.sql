-- DB update 2020_11_25_00 -> 2020_11_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_25_00 2020_11_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606305620937620900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606305620937620900');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature` SET `position_x`=10329, `position_y`=826.056, `position_z`=1326.37, `orientation`=2.72516 WHERE `guid`=46205; -- Ilthalaine
UPDATE `creature` SET `position_x`=-8933.93, `position_y`=-137.472, `position_z`=83.2960, `orientation`=2.2803 WHERE  `guid`=79942; -- Deputy Willem


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
