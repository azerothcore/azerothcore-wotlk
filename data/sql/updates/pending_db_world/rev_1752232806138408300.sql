DROP TABLE IF EXISTS `world_state`;
CREATE TABLE IF NOT EXISTS `world_state` (
   `Id` INT UNSIGNED NOT NULL COMMENT 'Internal save ID',
   `Data` longtext,
   PRIMARY KEY(`Id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='WorldState save system';
