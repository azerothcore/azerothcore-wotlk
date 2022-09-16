-- DB update 2021_10_07_14 -> 2021_10_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_14 2021_10_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632549631170638798'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632549631170638798');

-- Move Zhevra Runner 18658 spawn out from inside tree
UPDATE `creature` SET `position_x` = -831.5, `position_y` = -2614.1, `position_z` = 91.9, `orientation` = 3 WHERE `id` = 3242 AND `guid` = 18658;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_00' WHERE sql_rev = '1632549631170638798';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
