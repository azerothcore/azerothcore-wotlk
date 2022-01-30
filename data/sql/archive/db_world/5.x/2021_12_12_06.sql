-- DB update 2021_12_12_05 -> 2021_12_12_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_12_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_12_05 2021_12_12_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638937668620182300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638937668620182300');

/* Add completion quest text for 4485, 4486
*/

DELETE FROM `quest_offer_reward` WHERE `ID` IN (4485, 4486);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(4485, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, you\'ve returned to the Cathedral, $N. Good. A lot has happened recently, and I would seek your aid if you prove worthy.$B$BMany treacherous enemies are about. I will need your help to stop them.', 0),
(4486, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, you\'ve returned to the Cathedral, $N. Good. A lot has happened recently, and I would seek your aid if you prove worthy.$B$BMany treacherous enemies are about. I will need your help to stop them.', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_12_06' WHERE sql_rev = '1638937668620182300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
