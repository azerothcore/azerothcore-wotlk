INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649704204212585721');

DELETE FROM `item_template_locale` WHERE `ID`=13873 AND `locale` IN ('esES','esMX','ruRU','koKR','zhCN','frFR');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13873, 'esES', 'Llave de la Sala de visión', '', 0),
(13873, 'esMX', 'Llave de la Sala de visión', '', 0),
(13873, 'ruRU', 'Ключ от смотровой', '', 0),
(13873, 'koKR', '강당 열쇠', '', 0),
(13873, 'zhCN', '观察室钥匙', '', 0),
(13873, 'frFR', 'Clé de la Chambre des visions', '', 0);

