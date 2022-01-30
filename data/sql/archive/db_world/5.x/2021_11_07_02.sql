-- DB update 2021_11_07_01 -> 2021_11_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_07_01 2021_11_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636045459174422908'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636045459174422908');

# Sets spawntime of Sergeant Brashclaw to 2.5 hours
UPDATE `creature` SET `spawntimesecs` = 9000 WHERE `id` = 506;

# Sets spawntime of Slark to 2 hours
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 519;

# Sets spawntime of Brack to 2.5 hours
UPDATE `creature` SET `spawntimesecs` = 9000 WHERE `id` = 520;

# Sets spawntime of Foe Reaper 4000 to 5 hours
UPDATE `creature` SET `spawntimesecs` = 18000 WHERE `id` = 573;

# Sets spawntime of Master Digger to 2 hours
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 1424;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_07_02' WHERE sql_rev = '1636045459174422908';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
