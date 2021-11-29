-- DB update 2021_07_14_00 -> 2021_07_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_14_00 2021_07_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626123639599949300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626123639599949300');

DELETE FROM `quest_offer_reward` WHERE (`ID` = 1507);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(1507, 0, 0, 0, 0, 0, 0, 0, 0, 'Hm... $N. You are still new to your path, but I sense the possibility for greatness in you.$B$BYou were born with gifts, $N. See that they do not go to waste.', 12340);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_15_00' WHERE sql_rev = '1626123639599949300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
