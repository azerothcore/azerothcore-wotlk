-- DB update 2021_12_12_06 -> 2021_12_12_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_12_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_12_06 2021_12_12_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638942051959578400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638942051959578400');

/* Set quest 6164 to Eastern Plaguelands
*/

UPDATE `quest_poi` SET `WorldMapAreaId`=23 WHERE `QuestID`=6164 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=23 WHERE `QuestID`=6164 AND `id`=1;

/* Set quests 894, 900, 901, 902, 890, 892, 896, 888, 887 to The Barrens
*/

UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=890 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=892 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=896 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=896 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=888 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=888 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=888 AND `id`=2;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=887 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=887 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=887 AND `id`=2;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=887 AND `id`=3;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=894 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=900 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=900 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=900 AND `id`=2;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=900 AND `id`=3;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=901 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=901 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=11 WHERE `QuestID`=902 AND `id`=0;

/* Set quest 3924 completion to Orgrimmar
*/

UPDATE `quest_poi` SET `WorldMapAreaId`=321 WHERE `QuestID`=3924 AND `id`=3;

/* Set quests 1125 and 1126 to Silithus
*/

UPDATE `quest_poi` SET `WorldMapAreaId`=261 WHERE `QuestID`=1125 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=261 WHERE `QuestID`=1125 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=261 WHERE `QuestID`=1125 AND `id`=2;
UPDATE `quest_poi` SET `WorldMapAreaId`=261 WHERE `QuestID`=1126 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=261 WHERE `QuestID`=1126 AND `id`=1;

/* Set quest 6570 to Dustwallow Marsh
*/

UPDATE `quest_poi` SET `WorldMapAreaId`=141 WHERE `QuestID`=6570 AND `id`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_12_07' WHERE sql_rev = '1638942051959578400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
