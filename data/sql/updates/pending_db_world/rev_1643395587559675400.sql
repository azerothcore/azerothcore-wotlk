INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643395587559675400');

DROP TABLE IF EXISTS `instance_saved_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_data` (
  `id` int unsigned NOT NULL,
  `entry` int unsigned NOT NULL,
  `guid` int unsigned NOT NULL,
  `state` int unsigned DEFAULT '0',
  PRIMARY KEY (`id`,`entry`,`guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='id = instance.id\r\nentry = gameobject.entry\r\nguid = gameobject.guid\r\nstate = gameobject''s state';
