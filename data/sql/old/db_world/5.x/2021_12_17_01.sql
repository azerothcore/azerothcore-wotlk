-- DB update 2021_12_17_00 -> 2021_12_17_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_00 2021_12_17_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638951999039996100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638951999039996100');

/* Deprecate unused quest start item (pre-3.3, leads to Varimathras quests)
*/

UPDATE `item_template` SET `Flags` = 16 WHERE (`entry` = 17008);

/* Deprecate unused quest ID (pre-3.3, Varimathras is gone)
*/

INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(1, 6521, 0, 0, 0, 'Deprecated quest: An Unholy Alliance'),
(1, 6522, 0, 0, 0, 'Deprecated quest: An Unholy Alliance');

/* Update Map POI and Text for 'An Unholy Alliance' chain
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14352;
UPDATE `quest_poi` SET `WorldMapAreaId`=382 WHERE `QuestID`=14352 AND `id`=0;
UPDATE `quest_poi` SET `WorldMapAreaId`=382 WHERE `QuestID`=14352 AND `id`=1;
UPDATE `quest_poi` SET `WorldMapAreaId`=382 WHERE `QuestID`=14353 AND `id`=0;

/* Unrelated quests that also had incorrect POI texts
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14351;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Bragor Bloodfist at the Royal Quarter in the Undercity.' WHERE `ID`=14356;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_01' WHERE sql_rev = '1638951999039996100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
