-- DB update 2021_10_31_04 -> 2021_10_31_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_31_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_31_04 2021_10_31_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633781441009417000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633781441009417000');

-- Target: Felstone Field
UPDATE `quest_template` SET `RewardFactionOverride2`=50000 WHERE `ID`=5229;

-- Dead Man's Plea
UPDATE `quest_template` SET `RewardFactionOverride1`=100000 WHERE `ID`=8945;

-- Above and Beyond
UPDATE `quest_template` SET `RewardFactionOverride1`=100000 WHERE `ID`=5263;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_31_05' WHERE sql_rev = '1633781441009417000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
