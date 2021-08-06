-- DB update 2021_05_18_04 -> 2021_05_18_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_18_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_18_04 2021_05_18_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620908433024748200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620908433024748200');

UPDATE `quest_offer_reward` SET `RewardText` = 'Greetings young $c, I''m glad to see you ready and eager to learn about the curing of poisons.$B$BWhile most druids in the past were put through pre-planned trials, your work will involve no such thing.  There has been a rash of animal poisonings in Auberdine, and the village there has been unable to cure it.  To that end, a representative there has asked Moonglade for aid and we are sending you there to aid them.  This is no exercise - the work you''ll do is quite real.  Bear this in mind.' WHERE `ID` = 6121;
UPDATE `quest_offer_reward` SET `RewardText` = 'Greetings young $c, I''m glad to see you ready and eager to learn about the curing of poisons.$B$BWhile most druids in the past were put through pre-planned trials, your work will involve no such thing.  There has been a rash of animal poisonings at the Crossroads in the Barrens, and they''re unable to bring it under control.  Someone there has requested Moonglade for aid, so we are sending you there to aid them.  This is no exercise - the work you''ll do is quite real.  Bear this in mind.' WHERE `ID` = 6126;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
