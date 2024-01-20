-- DB update 2021_11_26_00 -> 2021_11_26_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_26_00 2021_11_26_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637854247802785100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637854247802785100');

UPDATE `smart_scripts` SET `target_type` = 28, `target_param1` = 40, `target_param2` = 1, `target_param3` = 1 WHERE `entryorguid` = 12101 AND `source_type` = 0 AND `id` = 0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_26_01' WHERE sql_rev = '1637854247802785100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
