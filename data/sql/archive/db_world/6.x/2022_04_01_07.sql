-- DB update 2022_04_01_06 -> 2022_04_01_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_06 2022_04_01_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648075927512739900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648075927512739900');

DELETE FROM `smart_scripts`  WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` IN (9, 10);
UPDATE `smart_scripts` SET `action_param2` = 45 WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `action_param2` = 44 WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` = 4;
UPDATE `smart_scripts` SET `id` = 9 WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` = 11;
UPDATE `smart_scripts` SET `id` = 10 WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` = 12;
UPDATE `smart_scripts` SET `id` = 11 WHERE `entryorguid` = 1373 AND `source_type` = 0 AND `id` = 13;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_07' WHERE sql_rev = '1648075927512739900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
