-- DB update 2022_03_18_07 -> 2022_03_18_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_18_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_18_07 2022_03_18_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647107182833454100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647107182833454100');

UPDATE `smart_scripts` SET `id` = 0 WHERE `entryorguid` = 11122 AND `action_type` = 11;
UPDATE `smart_scripts` SET `link` = 1 WHERE `entryorguid` = 11122 AND `action_type` = 11;
UPDATE `smart_scripts` SET `id` = 1 WHERE `entryorguid` = 11122 AND `action_type` = 36;
UPDATE `smart_scripts` SET `link` = 2 WHERE `entryorguid` = 11122 AND `action_type` = 36;
UPDATE `smart_scripts` SET `id` = 2 WHERE `entryorguid` = 11122 AND `action_type` = 29;
UPDATE `smart_scripts` SET `link` = 3 WHERE `entryorguid` = 11122 AND `action_type` = 29;
UPDATE `smart_scripts` SET `id` = 3 WHERE `entryorguid` = 11122 AND `action_type` = 41;
UPDATE `smart_scripts` SET `link` = 4 WHERE `entryorguid` = 11122 AND `action_type` = 41;
UPDATE `smart_scripts` SET `id` = 4 WHERE `entryorguid` = 11122 AND `action_type` = 33;
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 11122 AND `action_type` = 33;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_18_08' WHERE sql_rev = '1647107182833454100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
