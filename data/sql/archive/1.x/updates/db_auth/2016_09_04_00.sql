START TRANSACTION;

ALTER TABLE version_db_auth CHANGE COLUMN 2016_08_25_01 2016_09_04_00 bit;

CREATE TABLE `logs` (
  `time` int(10) unsigned NOT NULL,
  `realm` int(10) unsigned NOT NULL,
  `type` varchar(250) NOT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `string` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

COMMIT;
