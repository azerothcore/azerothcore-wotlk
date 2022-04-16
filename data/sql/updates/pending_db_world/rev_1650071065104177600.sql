INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650071065104177600');

DELETE FROM `item_template_locale` WHERE `ID`=13065 AND `locale` IN ('esES','esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13065, 'esES', 'Varita de Allistarj', '', '0'),
(13065, 'esMX', 'Varita de Allistarj', '', '0');

