-- DB update 2021_06_18_16 -> 2021_06_18_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_16 2021_06_18_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623837841509670000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623837841509670000');

DELETE FROM `item_template_locale` WHERE ID = '42482' AND locale = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES ('42482', 'zhCN', '紫罗兰监狱钥匙', '', '15050');

UPDATE `item_template_locale` SET `Name` = '护甲羊皮纸'  WHERE `ID` = '38682' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '护甲羊皮纸 II' , `Description` = '可以将护甲附魔写在羊皮纸上，以备将来使用。只能吸收等级限制在不低于35级的附魔。' WHERE `ID` = '37602' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '护甲羊皮纸 III' ,`Description` = "可以将护甲附魔写在羊皮纸上，以备将来使用。只能吸收等级限制在不低于60级的附魔。" WHERE `ID` = '43145' AND `locale` = 'zhCN';

UPDATE `item_template_locale` SET `Name` = '武器羊皮纸'  , `Description` = '可以将武器附魔写在羊皮纸上，以备将来使用。' WHERE `ID` = '39349' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '武器羊皮纸 II' , `Description` = '可以将武器附魔写在羊皮纸上，以备将来使用。只能吸收等级限制在不低于35级的附魔。' WHERE `ID` = '39350' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '武器羊皮纸 III' ,`Description` = "可以将武器附魔写在羊皮纸上，以备将来使用。只能吸收等级限制在不低于60级的附魔。" WHERE `ID` = '43146' AND `locale` = 'zhCN';

UPDATE `item_template_locale` SET `Name` = '源质矿石' WHERE `ID` = '18562' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '源质锭' WHERE `ID` = '17771' AND `locale` = 'zhCN';


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_17' WHERE sql_rev = '1623837841509670000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
