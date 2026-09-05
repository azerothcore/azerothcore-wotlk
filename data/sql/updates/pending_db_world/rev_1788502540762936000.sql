-- Quest 7703: remove POIs incorrectly pointing to Silverpine Forest instead of Dire Maul.
DELETE FROM `quest_poi_points` WHERE `QuestID` = 7703;
DELETE FROM `quest_poi` WHERE `QuestID` = 7703;
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Captain Kromcrush in Dire Maul.' WHERE `ID` = 7703;
UPDATE `quest_template_locale` SET `CompletedText` = 'Kehrt zu Hauptmann Krombruch in Düsterbruch zurück.' WHERE `ID` = 7703 AND `locale` = 'deDE';
UPDATE `quest_template_locale` SET `CompletedText` = 'Vuelve con el capitán Kromcrush en La Masacre.' WHERE `ID` = 7703 AND `locale` IN ('esES', 'esMX');
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir le Capitaine Kromcrabouille à Hache-Tripes.' WHERE `ID` = 7703 AND `locale` = 'frFR';
UPDATE `quest_template_locale` SET `CompletedText` = 'Вернитесь к капитану Давигрому в Забытом Городе.' WHERE `ID` = 7703 AND `locale` = 'ruRU';
UPDATE `quest_template_locale` SET `CompletedText` = '返回厄运之槌的克罗卡斯处。' WHERE `ID` = 7703 AND `locale` = 'zhCN';
