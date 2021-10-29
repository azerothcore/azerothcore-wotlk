ALTER TABLE characters_db_version CHANGE COLUMN 2016_08_12_00 2016_08_15_00 bit;

ALTER TABLE `channels`
  ADD `ownership` tinyint(3) unsigned NOT NULL DEFAULT '1' AFTER `announce`;
