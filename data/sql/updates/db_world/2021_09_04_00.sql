-- DB update 2021_09_03_05 -> 2021_09_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_03_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_03_05 2021_09_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630456715748683765'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630456715748683765');

-- add `Rusty Prison Key`(id 43650) Chinese translation
DELETE from `item_template_locale` where `ID` = 43650 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`,`locale`, `Name`, `Description`) VALUES ('43650','zhCN', '生锈的监狱钥匙', '看起来像一把打开水下宝箱的钥匙。。。'); 

-- add `Shadowforge Key`(id 11000) Chinese translation
DELETE from `item_template_locale` where `ID` = 11000 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`,`locale`, `Name`, `Description`) VALUES ('11000','zhCN', '暗炉钥匙', '通往黑石深渊的钥匙。。。'); 

-- add `Heroic Key to the Focusing Iris`(id 44581) Chinese translation
DELETE from `item_template_locale` where `ID` = 44581 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES ('44581', 'zhCN', '英雄聚焦之虹的钥匙', '', '15050'); 

-- add `Key to the Focusing Iris`(id 44582) Chinese translation
DELETE from `item_template_locale` where `ID` = 44582 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES ('44582', 'zhCN', '聚焦之虹的钥匙', '', '15050'); 

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_04_00' WHERE sql_rev = '1630456715748683765';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
