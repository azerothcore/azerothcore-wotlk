-- DB update 2021_11_22_00 -> 2021_11_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_22_00 2021_11_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636703045917932956'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636703045917932956');

DELETE FROM `quest_poi` WHERE `QuestID` = 6662;
DELETE FROM `quest_poi_points` WHERE `QuestID` = 6662;

INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`)
VALUES(6662, 0, -1, 0, 0, 0, 0, 0, 0);

INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`)
VALUES(6662, 1, -1, 0, 0, 0, 0, 0, 0);

INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`, `Idx2`, `X`,`Y`, `VerifiedBuild`)
VALUES (6662, 0, 0, -4838, -1318, 0);

INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`, `Idx2`, `X`,`Y`, `VerifiedBuild`)
VALUES (6662, 1, 0, -8364, 535, 0);



--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_22_01' WHERE sql_rev = '1636703045917932956';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
