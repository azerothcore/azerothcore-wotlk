INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611865917828980400');
DELETE FROM `item_template_locale` WHERE `ID` IN (30622,30637) and locale = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30622, 'zhCN', '焰铸钥匙', '允许你进入英雄难度的地狱火堡垒地下城。', 15050),
(30637, 'zhCN', '焰铸钥匙', '允许你进入英雄难度的地狱火堡垒地下城。', 15050);
