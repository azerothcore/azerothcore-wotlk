-- DB update 2021_11_15_03 -> 2021_11_15_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_15_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_15_03 2021_11_15_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636665257418709911'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636665257418709911');

-- Ancient creature_equip_template with item models, first found item with that model
UPDATE `creature_equip_template` SET `ItemID1`='1907', `ItemID2`='0' WHERE  `CreatureID`=3203 AND `ID`=1;

-- Vmangos
UPDATE `creature_equip_template` SET `ItemID1`='2177', `VerifiedBuild`='31727' WHERE  `CreatureID`=4667 AND `ID`=1;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_15_04' WHERE sql_rev = '1636665257418709911';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
