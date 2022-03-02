INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1643629468629316100');

DROP TABLE IF EXISTS `instance_saved_go_state_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_go_state_data` (
  `id` INT UNSIGNED NOT NULL COMMENT 'instance.id',
  `guid` INT UNSIGNED NOT NULL COMMENT 'gameobject.guid',
  `state` TINYINT UNSIGNED DEFAULT '0' COMMENT 'gameobject.state',
  PRIMARY KEY (`id`, `guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;