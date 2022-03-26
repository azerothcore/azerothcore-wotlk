-- DB update 2022_03_01_01 -> 2022_03_01_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_01_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_01_01 2022_03_01_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644957293951535000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644957293951535000');

ALTER TABLE `quest_request_items` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quest_details` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quest_offer_reward` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;

UPDATE `quest_request_items` SET `EmoteOnComplete`=0, `EmoteOnIncomplete`=0, `VerifiedBuild`=42083 WHERE `ID`=2178;
UPDATE `quest_offer_reward` SET `Emote1`=5, `VerifiedBuild`=42083 WHERE `ID`=2178;

DELETE FROM `quest_details` WHERE `ID` = 2178;
INSERT INTO `quest_details` (`ID`, `Emote1`, `VerifiedBuild`) VALUES (2178, 1, 42083);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_01_02' WHERE sql_rev = '1644957293951535000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
