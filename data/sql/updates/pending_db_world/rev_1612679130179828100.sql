INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612679130179828100');

DELETE FROM `item_template_locale` WHERE `ID` IN (30623,30633,30634,30635,24490) AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30623, 'zhCN', '水库钥匙', '允许你进入英雄难度的盘牙水库地下城。', 15050),
(30633, 'zhCN', '奥金尼钥匙', '允许你进入英雄难度的奥金顿地下城。', 15050),
(30634, 'zhCN', '星船钥匙', '允许你进入英雄难度的风暴要塞地下城。', 15050),
(30635, 'zhCN', '时光之钥', '允许你进入英雄难度的时光之穴地下城。', 15050),
(24490, 'zhCN', '麦迪文的钥匙', '', 15050);
