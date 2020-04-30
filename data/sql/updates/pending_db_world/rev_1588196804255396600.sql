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
('mythic', 0, 'Syntax: .mythic [#level]\r\n\r\nSets your (and your groups) Dungeon Difficulty to mythic. If a level is set, sets that mythic plus dungeon to that level.');

-- TEST DUNGEON: NEXUS
DELETE FROM `access_requirement` WHERE `mapId`=576 AND `difficulty`=2;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(576, 2, 80, 0, 0, 0, 0, 0, 0, NULL, 'The Nexus (Mythic Plus)');

DELETE FROM `map_difficulty_data` WHERE `MapId`=576 AND `Difficulty`=2;
INSERT INTO `map_difficulty_data` (`MapId`, `Difficulty`, `ParentDifficulty`, `Comment`) VALUES 
(576, 2, 1, 'The Nexus (Mythic Plus)');

-- Spawn stuff in mythic too
UPDATE creature SET spawnMask = spawnmask | 4 WHERE map = 576;
UPDATE gameobject SET spawnMask = spawnmask | 4 WHERE map = 576;