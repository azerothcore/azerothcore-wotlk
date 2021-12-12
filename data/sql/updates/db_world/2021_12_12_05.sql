-- DB update 2021_12_12_04 -> 2021_12_12_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_12_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_12_04 2021_12_12_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638933646064544700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638933646064544700');

/* Fix incorrect quest tracking status.
*/

UPDATE `quest_template` SET `QuestCompletionLog`='Return to Mound of Dirt in The Eastern Plaguelands' WHERE `ID`=6024;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE `ID`=2199;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE `ID`=2204;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Talvash del Kissel at the Mystic Ward in Ironforge.' WHERE `ID`=8355;
UPDATE `quest_template` SET `QuestCompletionLog`='Return to Shen\'dralar Ancient in Dire Maul.' WHERE `ID`=7461;

/* Remove quest completion question mark off of map
*/

UPDATE `quest_poi` SET `ObjectiveIndex`=0 WHERE  `QuestID`=7461 AND `id`=2;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_12_05' WHERE sql_rev = '1638933646064544700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
