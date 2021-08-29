-- DB update 2020_04_17_00 -> 2020_04_17_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_17_00 2020_04_17_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584052298613344800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584052298613344800');

UPDATE `quest_offer_reward` SET `RewardText` = 'Listen well, $c. In accepting this weapon your fate is sealed.$B$BOvercome or succumb.$B$BI have placed your feet upon this path. You are therefore my personal responsibility. Should you failter, I am duty-bound to deliver you from this life.$B$BRemember my words, $r, and do not fail.' WHERE `id` = 24743;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
