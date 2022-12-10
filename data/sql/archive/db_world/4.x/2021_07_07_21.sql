-- DB update 2021_07_07_20 -> 2021_07_07_21
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_20';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_20 2021_07_07_21 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625583552450565968'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625583552450565968');

-- Correct Ironfur Bear spawn position
UPDATE `creature` SET `position_x` = -4120.52, `position_y` = -621.2, `position_z` = -18.74 WHERE `id` = 5268 AND `guid` = 50650;

-- Correct Longtooth Runner spawn position
UPDATE `creature` SET `position_x` = -4270.84, `position_y` = 36.42,  `position_z` =  55.14 WHERE `id` = 5286 AND `guid` = 50875;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_21' WHERE sql_rev = '1625583552450565968';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
