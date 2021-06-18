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

