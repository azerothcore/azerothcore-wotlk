INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649704204212585721');

DELETE FROM `item_template_locale` WHERE `ID`=13873 AND `locale` IN ('esES','esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13873, 'esES', 'Llave de la Sala de visión', '', '0'),
(13873, 'esMX', 'Llave de la Sala de visión', '', '0');

