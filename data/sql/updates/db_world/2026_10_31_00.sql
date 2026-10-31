-- DB update 2026_10_28_01 -> 2026_10_31_00
--
-- Move the acore_string texts from the locale_* columns to acore_string_locale.
-- A non-empty row already in acore_string_locale wins over the column, as it did in the loader.
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'koKR' AND `l`.`content` <> '' SET `s`.`locale_koKR` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'frFR' AND `l`.`content` <> '' SET `s`.`locale_frFR` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'deDE' AND `l`.`content` <> '' SET `s`.`locale_deDE` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'zhCN' AND `l`.`content` <> '' SET `s`.`locale_zhCN` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'zhTW' AND `l`.`content` <> '' SET `s`.`locale_zhTW` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'esES' AND `l`.`content` <> '' SET `s`.`locale_esES` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'esMX' AND `l`.`content` <> '' SET `s`.`locale_esMX` = `l`.`content`;
UPDATE `acore_string` AS `s` JOIN `acore_string_locale` AS `l` ON `l`.`entry` = `s`.`entry` AND `l`.`locale` = 'ruRU' AND `l`.`content` <> '' SET `s`.`locale_ruRU` = `l`.`content`;

DELETE FROM `acore_string_locale` WHERE `locale` IN ('koKR', 'frFR', 'deDE', 'zhCN', 'zhTW', 'esES', 'esMX', 'ruRU') AND `entry` IN (SELECT `entry` FROM `acore_string`);
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`)
SELECT `entry`, 'koKR', `locale_koKR` FROM `acore_string` WHERE `locale_koKR` <> ''
UNION ALL SELECT `entry`, 'frFR', `locale_frFR` FROM `acore_string` WHERE `locale_frFR` <> ''
UNION ALL SELECT `entry`, 'deDE', `locale_deDE` FROM `acore_string` WHERE `locale_deDE` <> ''
UNION ALL SELECT `entry`, 'zhCN', `locale_zhCN` FROM `acore_string` WHERE `locale_zhCN` <> ''
UNION ALL SELECT `entry`, 'zhTW', `locale_zhTW` FROM `acore_string` WHERE `locale_zhTW` <> ''
UNION ALL SELECT `entry`, 'esES', `locale_esES` FROM `acore_string` WHERE `locale_esES` <> ''
UNION ALL SELECT `entry`, 'esMX', `locale_esMX` FROM `acore_string` WHERE `locale_esMX` <> ''
UNION ALL SELECT `entry`, 'ruRU', `locale_ruRU` FROM `acore_string` WHERE `locale_ruRU` <> '';

ALTER TABLE `acore_string`
  DROP COLUMN `locale_koKR`,
  DROP COLUMN `locale_frFR`,
  DROP COLUMN `locale_deDE`,
  DROP COLUMN `locale_zhCN`,
  DROP COLUMN `locale_zhTW`,
  DROP COLUMN `locale_esES`,
  DROP COLUMN `locale_esMX`,
  DROP COLUMN `locale_ruRU`;
