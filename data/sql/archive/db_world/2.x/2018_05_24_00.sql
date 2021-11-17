-- DB update 2018_05_21_00 -> 2018_05_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_05_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_05_21_00 2018_05_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1526717821898752673'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1526717821898752673');

UPDATE `quest_template_addon` SET `RewardMailTemplateID` = 236 WHERE `id` = 12711;

DELETE FROM `mail_loot_template` WHERE `entry` = 236;
INSERT INTO `mail_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES (236,39317,100,1,0,1,1);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
