INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1646372997041985700');

-- autobroadcast_locale
DROP TABLE IF EXISTS `autobroadcast_locale`;
CREATE TABLE IF NOT EXISTS `autobroadcast_locale` (
  `RealmID` INT NOT NULL DEFAULT -1,
  `ID` TINYINT NOT NULL,
  `Locale` enum('enUS','koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU') NOT NULL,
  `Text` TEXT DEFAULT NULL,
  PRIMARY KEY (`RealmID`, `ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
