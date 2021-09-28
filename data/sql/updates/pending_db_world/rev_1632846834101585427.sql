INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632846834101585427');

-- Correct Quest marker text
UPDATE `quest_template` SET `QuestCompletionLog` = 'Return to Keeper Bel\'dugur at Apothecarium in the Undercity.' WHERE `ID` = 1013;

-- esES & esMX
UPDATE `quest_template_locale` SET `CompletedText` = 'Vuelve con: Guardián Bel\'dugur. Zona: Apothecarium de Entrañas.' WHERE `ID` = 1013 AND `locale` IN ('esES', 'esMX');

-- frFR
UPDATE `quest_template_locale` SET `CompletedText` = 'Retournez voir le Gardien Bel\'dugur au  à l\'Apothicarium à Undercity' WHERE `ID` = 1013 AND `locale` = 'frFR';

