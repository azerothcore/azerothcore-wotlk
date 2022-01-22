-- DB update 2021_07_21_00 -> 2021_07_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_21_00 2021_07_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626390963148739000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626390963148739000');

-- fixed Chinese translation errors
UPDATE `item_template_locale` SET `Name` = '凶残角斗士的恐怖板甲头盔' ,`Description` = '' WHERE `ID` = '40817' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '完美辉光茶晶石' , `Description` = '对应红色或黄色插槽。' WHERE `ID` = '41494' AND `locale` = 'zhCN';

-- add `Pillar of Diamond`(id 2842) Chinese translation
DELETE from `gameobject_template_locale` where `entry` = 2842 AND `locale` = 'zhCN';
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `VerifiedBuild`) VALUES ('2842', 'zhCN', '钻石石柱', '', '18019');

-- add `Pillar of Opal`(id 2848) Chinese translation
DELETE from `gameobject_template_locale` where `entry` = 2848 AND `locale` = 'zhCN';
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `VerifiedBuild`) VALUES ('2848', 'zhCN', '玛瑙石柱', '', '18019');

-- add `Pillar of Amethyst`(id 2858) Chinese translation
DELETE from `gameobject_template_locale` where `entry` = 2858 AND `locale` = 'zhCN';
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `VerifiedBuild`) VALUES ('2858', 'zhCN', '紫水晶石柱', '', '18019'); 

-- fixed name error
UPDATE `creature_template_locale` SET `Title` = '勇气纹章军需官' WHERE `entry` = '31581' AND `locale` = 'zhCN';


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_21_01' WHERE sql_rev = '1626390963148739000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
