-- DB update 2022_03_27_18 -> 2022_03_27_19
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_18';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_18 2022_03_27_19 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642567672467945212'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642567672467945212');

UPDATE `smart_scripts` SET `event_param2`=0 WHERE `entryorguid`=17215 AND `source_type`=0 AND `id`=2 AND `link`=0;
UPDATE `smart_scripts` SET `event_param2`=0 WHERE `entryorguid`=17214 AND `source_type`=0 AND `id`=0 AND `link`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_19' WHERE sql_rev = '1642567672467945212';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
