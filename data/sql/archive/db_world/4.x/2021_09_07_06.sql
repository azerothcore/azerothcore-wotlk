-- DB update 2021_09_07_05 -> 2021_09_07_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_07_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_07_05 2021_09_07_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630703356735581407'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630703356735581407');

-- Change to correct objective tracker and add correct translate objective

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Count Remington Ridgewell at Stormwind Keep in Stormwind City' WHERE `ID` = 543;
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '将匹瑞诺德王冠带给暴风城的雷明顿·瑞治维尔。' WHERE `ID` = 543 AND `locale` = 'zhCN';
-- zhTW
UPDATE `quest_template_locale` SET `CompletedText` = '将匹瑞诺德王冠带给暴风城的雷明顿·瑞治维尔。' WHERE `ID` = 543 AND `locale` = 'zhTW';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_06' WHERE sql_rev = '1630703356735581407';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
