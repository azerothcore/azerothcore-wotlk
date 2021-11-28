-- DB update 2021_11_02_03 -> 2021_11_02_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_02_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_02_03 2021_11_02_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635418346534500600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635418346534500600');

UPDATE `broadcast_text` SET `MaleText`='prepares a Great Feast!', `FemaleText`='prepares a Great Feast!' WHERE `ID`=31843;

UPDATE `broadcast_text` SET `MaleText`='prepares a Small Feast!', `FemaleText`='prepares a Small Feast!' WHERE `ID`=31845;

UPDATE `broadcast_text` SET `MaleText`='prepares a Fish Feast!', `FemaleText`='prepares a Fish Feast!' WHERE `ID`=31844;

UPDATE `broadcast_text` SET `FemaleText`='prepares a Gigantic Feast!', `MaleText`='prepares a Gigantic Feast!' WHERE `ID`=31846;

UPDATE `broadcast_text` SET `VerifiedBuild`=0 WHERE `ID` IN (31843,31845,31844,31846);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_02_04' WHERE sql_rev = '1635418346534500600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
