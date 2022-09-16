-- DB update 2018_11_15_00 -> 2018_11_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_11_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_11_15_00 2018_11_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1542756898843297200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1542756898843297200');
UPDATE `quest_template` SET `OfferRewardText`='Another one of Eitrigg\'s recruits, hm?$B$BA sorry state of affairs we find ourselves in if this is the best the Horde can produce. No matter. By the time we think you\'re ready to leave the Valley, you\'ll be a proud warrior of the Horde.' WHERE  `ID`=787;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
