INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643395587559675400');

DROP TABLE IF EXISTS `instance_saved_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_data` (
  `instance_id` int unsigned NOT NULL,
  `gameobject_entry` int unsigned NOT NULL,
  `gameobject_guid` int unsigned NOT NULL,
  `gameobject_state` int unsigned DEFAULT '0',
  PRIMARY KEY (`instance_id`,`gameobject_entry`,`gameobject_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
