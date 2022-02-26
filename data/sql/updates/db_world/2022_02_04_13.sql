-- DB update 2022_02_04_12 -> 2022_02_04_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_12 2022_02_04_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643662892603722900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643662892603722900');

UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `RegenHealth` >= 2;
UPDATE `creature_onkill_reputation` SET `IsTeamAward1` = 0 WHERE `IsTeamAward1` >= 2;
UPDATE `creature_onkill_reputation` SET `IsTeamAward2` = 0 WHERE `IsTeamAward2` >= 2;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_13' WHERE sql_rev = '1643662892603722900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
