-- DB update 2022_05_11_01 -> 2022_05_11_02
-- update Wintergrasp battle announce Chinese translation
UPDATE `acore_string` SET `locale_zhCN` = '|cffff0000[冬拥湖]:|r 战斗开始了！|r' WHERE `entry` = 20078; 

-- add object's Chinese translation
DELETE from `gameobject_template_locale` where `entry` IN (175226,175230,175233,176191,176197,176198) AND `locale` = 'zhCN';
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `VerifiedBuild`) VALUES 
(175226, 'zhCN', '搁浅的海洋生物', '', 0),
(175230, 'zhCN', '搁浅的海洋生物', '', 0),
(175233, 'zhCN', '搁浅的海洋生物', '', 0),
(176191, 'zhCN', '搁浅的海龟', '', 0),
(176197, 'zhCN', '搁浅的海龟', '', 0),
(176198, 'zhCN', '搁浅的海龟', '', 0);

-- add an item's Chinese translation
DELETE from `item_template_locale` where `ID` = 27808 AND `locale` = 'zhCN';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES ( 27808, 'zhCN', '超级蹦床4000型的钥匙', '钥匙上刻有一行小字：瓦萨特不对使用超级蹦床4000型所造成的任何后果负责。', -12340);
