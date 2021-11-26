-- DB update 2021_09_01_08 -> 2021_09_01_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_08 2021_09_01_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630089599912305764'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630089599912305764');

-- Decreases the respawntime for Garrick Padfoot to 60 s (90 s in real time when instantly looted)
UPDATE `creature` SET `spawntimesecs` = 60 WHERE `id` = 103 AND `guid` = 80247;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_09' WHERE sql_rev = '1630089599912305764';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
