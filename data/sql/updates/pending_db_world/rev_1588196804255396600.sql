INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588196804255396600');

DROP TABLE IF EXISTS `map_difficulty_data`;
CREATE TABLE IF NOT EXISTS `map_difficulty_data` (
  `mapId` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `difficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `parentDifficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment` TEXT,
  PRIMARY KEY (`mapId`, `difficulty`)
) ENGINE=MYISAM;

DELETE FROM `command` WHERE `name`='mythic';
INSERT INTO `command` VALUES 
('mythic', 0, 'Syntax: .mythic\r\n\r\nSets your (and your groups) Dungeon Difficulty to mythic.');
