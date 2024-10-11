-- DB update 2020_04_30_00 -> 2020_04_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_30_00 2020_04_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584790013870207000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584790013870207000');

-- Set rates to 1 for faction "The Mag'har" & "Kurenai" to be blizzlike
UPDATE `reputation_reward_rate` SET `quest_rate`=1, `quest_daily_rate`=1, `quest_repeatable_rate`=1 WHERE `faction`=941;
UPDATE `reputation_reward_rate` SET `quest_daily_rate`=1, `quest_repeatable_rate`=1, `spell_rate`=1 WHERE `faction`=978;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
