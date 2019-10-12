INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570914351382462135');

ALTER TABLE `points_of_interest` CHANGE `Data` `Importance` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `points_of_interest` ADD `VerifiedBuild` smallint(5) DEFAULT '0';
