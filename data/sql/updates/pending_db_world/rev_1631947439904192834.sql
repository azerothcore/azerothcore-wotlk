INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631947439904192834');

-- Correct handin location for Twisted Hatred
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Tallonkai Swiftroot at Dolanaar in Teldrassil.' WHERE `ID` = 932;

