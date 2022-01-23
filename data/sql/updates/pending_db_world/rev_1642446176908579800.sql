INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642446176908579800');

UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE `ID` IN (9211, 9213);
