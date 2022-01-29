INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643395587559675400');

DROP TABLE IF EXISTS `instance_saved_go_state_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_go_state_data` (
  `id` int unsigned NOT NULL COMMENT 'id = instance.id',
  `entry` int unsigned NOT NULL COMMENT 'entry = gameobject.entry',
  `guid` int unsigned NOT NULL COMMENT 'guid = gameobject.guid',
  `state` int unsigned DEFAULT '0' COMMENT 'state = gameobject.state',
  PRIMARY KEY (`id`,`entry`,`guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
