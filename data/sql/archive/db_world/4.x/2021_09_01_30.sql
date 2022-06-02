-- DB update 2021_09_01_29 -> 2021_09_01_30
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_29';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_29 2021_09_01_30 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630405831769074100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630405831769074100');

-- Corrected faction for Southshore Guard
UPDATE `creature_template` SET `faction` = 11 WHERE (`entry` = 2386);

-- Corrected faction for Shadowy Assassins
UPDATE `creature_template` SET `faction` = 97 WHERE (`entry` = 2434);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_30' WHERE sql_rev = '1630405831769074100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
