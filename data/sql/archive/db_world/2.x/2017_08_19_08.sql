-- DB update 2017_08_19_07 -> 2017_08_19_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_07 2017_08_19_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1493343523138941000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1493343523138941000');
-- replace "Mac" with actual player name ($N) in the reward text
UPDATE `quest_template`
SET `OfferRewardText`= "Great Spirit Totem! This is dire news indeed. I must begin to plan for whatever may come.$b$b$N, as promised, here is your reward for your brave service.$b$b"
WHERE `ID`= 5064;
--
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
