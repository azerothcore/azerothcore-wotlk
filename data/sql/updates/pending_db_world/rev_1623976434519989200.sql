INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623976434519989200');

-- acore_string_locale
DROP TABLE IF EXISTS `acore_string_locale`;
CREATE TABLE IF NOT EXISTS `acore_string_locale` (
  `entry` int(10) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `content` text,
  PRIMARY KEY (`entry`, `locale`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- koKR
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "koKR", `locale_koKR` FROM `acore_string` WHERE LENGTH(`locale_koKR`) > 0);

-- frFR
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "frFR", `locale_frFR` FROM `acore_string` WHERE LENGTH(`locale_frFR`) > 0);

-- deDE
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "deDE", `locale_deDE` FROM `acore_string` WHERE LENGTH(`locale_deDE`) > 0);

-- zhCN
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "zhCN", `locale_zhCN` FROM `acore_string` WHERE LENGTH(`locale_zhCN`) > 0);

-- zhTW
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "zhTW", `locale_zhTW` FROM `acore_string` WHERE LENGTH(`locale_zhTW`) > 0);

-- esES
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "esES", `locale_esES` FROM `acore_string` WHERE LENGTH(`locale_esES`) > 0);

-- esMX
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "esMX", `locale_esMX` FROM `acore_string` WHERE LENGTH(`locale_esMX`) > 0);

-- ruRU
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
  (SELECT `entry`, "ruRU", `locale_ruRU` FROM `acore_string` WHERE LENGTH(`locale_ruRU`) > 0);

-- acore_string

ALTER TABLE `acore_string` CHANGE `content_default` `content` LONGTEXT;

ALTER TABLE `acore_string`
    DROP COLUMN `locale_koKR`,
    DROP COLUMN `locale_frFR`,
    DROP COLUMN `locale_deDE`,
    DROP COLUMN `locale_zhCN`,
    DROP COLUMN `locale_zhTW`,
    DROP COLUMN `locale_esES`,
    DROP COLUMN `locale_esMX`,
    DROP COLUMN `locale_ruRU`;
