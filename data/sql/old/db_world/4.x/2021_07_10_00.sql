-- DB update 2021_07_09_06 -> 2021_07_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_09_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_09_06 2021_07_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625736069367927700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625736069367927700');

-- ID: 11874 - Masat T'andr
-- faction was 1638, speed_run was 1
UPDATE `creature_template` SET `faction` = 35, `speed_run` = 1.14286 WHERE (`entry` = 11874);

-- ID: 11198 - Broken Exile
-- faction was 1638, speed_run was 1
UPDATE `creature_template` SET `faction` = 15, `speed_run` = 1.14286 WHERE (`entry` = 11198);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_10_00' WHERE sql_rev = '1625736069367927700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
