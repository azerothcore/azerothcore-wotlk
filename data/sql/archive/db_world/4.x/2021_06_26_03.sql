-- DB update 2021_06_26_02 -> 2021_06_26_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_26_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_26_02 2021_06_26_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624198243312398771'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624198243312398771');

-- Add POI for the quest objective of Waters of Xavian (1944)
DELETE FROM `quest_poi` WHERE `QuestId`=1944 AND `id`=1;
INSERT INTO `quest_poi` (`QuestId`, `id`, `ObjectiveIndex`, `MapId`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES (1944, 1, 4, 1, 43, 0, 0, 1, 0);
DELETE FROM `quest_poi_points` WHERE `QuestId`=1944 AND `Idx1`=1;
INSERT INTO `quest_poi_points` (`QuestId`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES (1944, 1, 0, 3079, -2701, 0);

-- Add POIs for the quest objective of Laughing Sisters (1945)
DELETE FROM `quest_poi` WHERE `QuestId`=1945 AND `id`=1;
INSERT INTO `quest_poi` (`QuestId`, `id`, `ObjectiveIndex`, `MapId`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`) VALUES (1945, 1, 4, 1, 43, 0, 0, 1, 0);
DELETE FROM `quest_poi_points` WHERE `QuestId`=1945 AND `Idx1`=1;
INSERT INTO `quest_poi_points` (`QuestId`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(1945, 1, 0, 2797, -1812, 0),
(1945, 1, 1, 2524, -1801, 0),
(1945, 1, 2, 2519, -1618, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_26_03' WHERE sql_rev = '1624198243312398771';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
