-- DB update 2021_06_29_00 -> 2021_06_29_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_29_00 2021_06_29_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624278065288710000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624278065288710000');

UPDATE `creature_template_locale` SET `Title` = '寒冰纹章军需官' WHERE `entry` IN (37942,37941) AND `locale` = 'zhCN';
UPDATE `creature_template_locale` SET `Title` = '凯旋纹章军需官' WHERE `entry` IN (35495,35494) AND `locale` = 'zhCN';
UPDATE `creature_template_locale` SET `Title` = '征服纹章军需官' WHERE `entry` IN (33964,33963) AND `locale` = 'zhCN';
UPDATE `creature_template_locale` SET `Title` = '英雄纹章军需官' WHERE `entry` IN (31582,31581,31580) AND `locale` = 'zhCN';
UPDATE `creature_template_locale` SET `Title` = '勇气纹章军需官' WHERE `entry` IN (31579) AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '英雄纹章' WHERE `id` IN (40752) AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '勇气纹章' WHERE `id` IN (40753) AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '征服纹章' WHERE `id` IN (45624) AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '凯旋纹章' WHERE `id` IN (47241) AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '寒冰纹章' WHERE `id` IN (49426) AND `locale` = 'zhCN';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_29_01' WHERE sql_rev = '1624278065288710000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
