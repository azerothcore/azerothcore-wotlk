-- DB update 2021_10_08_17 -> 2021_10_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_17 2021_10_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633685012101382248'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633685012101382248');

-- Stone circle quest (3444) correct POIs

DELETE FROM `quest_poi_points` WHERE `QuestID`= 3444;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES 
(3444, 0, 0, -992, -3710, 0),
(3444, 1, 0, -7988, -3856, 0);

DELETE FROM `quest_poi` WHERE `QuestID`= 3444;
INSERT INTO `quest_poi` (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES 
(3444, 0, 4, 1, 11, 0, 0, 1, 0),
(3444, 1, -1, 1, 161, 0, 0, 1, 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_09_00' WHERE sql_rev = '1633685012101382248';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
