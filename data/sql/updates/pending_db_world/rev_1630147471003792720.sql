INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630147471003792720');

UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Bashana Runetotem at Elder Rise in Thunder Bluff.' WHERE `ID` = 6561;

-- frFR
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir Bashana Runetotem à Elder Rise, Thunder Bluff.' WHERE `ID` = 6561 AND `locale` = 'frFR';
-- zhCN
UPDATE `quest_template_locale` SET `CompletedText` = '在雷霆崖的长者高地找到芭莎娜符文图腾。.' WHERE `ID` = 6561 AND `locale` = 'zhCN';
-- ruRU
UPDATE `quest_template_locale` SET `CompletedText` = 'Вернитесь к Башану Руническому Тотему в Восстание Старейших, что в Громовом Утесе.' WHERE `ID` = 6561 AND `locale` = 'ruRU';
-- esMX
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa a: Bashana Runetotem. Zona: The Elder Rise, Cima del Trueno..' WHERE `ID` = 6561 AND `locale` = 'esMX';
-- esES
UPDATE `quest_template_locale` SET `CompletedText` = 'Regresa a: Bashana Runetotem. Zona: The Elder Rise, Cima del Trueno..' WHERE `ID` = 6561 AND `locale` = 'esES';
