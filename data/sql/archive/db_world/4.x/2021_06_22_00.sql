-- DB update 2021_06_21_00 -> 2021_06_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_21_00 2021_06_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621064404059904900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621064404059904900');
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Mennet Carkad at Undercity in the Rogues\' Quarter.' WHERE (`ID` = 1899);
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Mennet Carkad at Undercity in the Rogues\' Quarter.' WHERE (`ID` = 1886);
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Andron Gant at Undercity in the Apothecarium.' WHERE (`ID` = 14419);
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Mennet Carkad at Undercity in the Rogues\' Quarter.' WHERE (`ID` = 14421);
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Mennet Carkad at Undercity in the Rogues\' Quarter.' WHERE (`ID` = 14420);
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Aleric Hawkins at Undercity in the Hall of the Dark Lady.' WHERE (`ID` = 14418);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_22_00' WHERE sql_rev = '1621064404059904900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
