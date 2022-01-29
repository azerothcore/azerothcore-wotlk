INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643395587559675400');

DROP TABLE IF EXISTS `instance_saved_go_state_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_go_state_data` (
  `id` INT UNSIGNED NOT NULL COMMENT 'instance.id',
  `entry` INT UNSIGNED NOT NULL COMMENT 'gameobject_template.entry',
  `guid` INT UNSIGNED NOT NULL COMMENT 'gameobject.guid',
  `state` INT UNSIGNED DEFAULT '0' COMMENT 'gameobject.state',
  PRIMARY KEY (`id`, `entry`, `guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
