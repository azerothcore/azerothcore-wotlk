INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588196804255396600');

DROP TABLE IF EXISTS `map_difficulty_data`;
CREATE TABLE IF NOT EXISTS `map_difficulty_data` (
  `MapId` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `Difficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `ParentDifficulty` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `Comment` TEXT,
  PRIMARY KEY (`MapId`, `Difficulty`)
) ENGINE=MYISAM;

DELETE FROM `command` WHERE `name`='mythic';
INSERT INTO `command` VALUES 
('mythic', 0, 'Syntax: .mythic\r\n\r\nSets your (and your groups) Dungeon Difficulty to mythic.');
