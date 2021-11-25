-- DB update 2021_07_22_06 -> 2021_07_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_22_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_22_06 2021_07_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626545461944168600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626545461944168600');

-- We change the quest reward to use the name and gender of our character.
UPDATE `quest_offer_reward` SET `RewardText` = 'Incredible! Improbable! Simply amazing! You\'ve got talent, $N. Either that or you\'re the luckiest $gman:woman; alive!$b$bHere\'s your cut of the action. I\'m sure you would make better use of this stuff than I could.$b$b' WHERE (`ID` = 2381);



--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_00' WHERE sql_rev = '1626545461944168600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
