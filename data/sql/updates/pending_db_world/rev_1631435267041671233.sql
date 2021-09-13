INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631435267041671233');

-- Frostmane Hold

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Senir Whitebeard at Kharanos in Dun Morogh.' WHERE `ID` = 287;
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '前往丹莫罗并在卡拉诺斯找到塞内尔·白胡子。' WHERE `ID` = 287 AND `locale` = 'zhCN';

-- Stocking Jetsteam

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Pilot Bellowfiz at Steelgrill\'s in Dun Morogh.' WHERE `ID` = 317;
-- esES
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa con Piloto Bramiz en Steelgrill\'s en Dun Morogh.' WHERE `ID` = 317 AND `locale` = 'esES';
-- esMX
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa con Piloto Bramiz en Steelgrill\'s en Dun Morogh.' WHERE `ID` = 317 AND `locale` = 'esMX';
-- frFR
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir le Pilote Claquesoufflet au Steelgrill\'s à Dun Morogh' WHERE `ID` = 317 AND `locale` = 'frFR';
-- ruRU
UPDATE `quest_template_locale` SET `CompletedText` = 'Вернитесь к Пилот Толстопуз в Сталегрилл в Дун Мороге.' WHERE `ID` = 317 AND `locale` = 'ruRU';
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '把它们交给钢架补给站的驾驶员贝隆·风箱。' WHERE `ID` = 317 AND `locale` = 'zhCN';

-- Ferocitas the dream eater

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Tallonkai Swiftroot at Dolanaar in Teldrassil.' WHERE `ID` = 2459;
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '返回泰达希尔多兰纳尔的塔隆凯迅根。' WHERE `ID` = 2459 AND `locale` = 'zhCN';
