-- DB update 2026_03_10_01 -> 2026_03_11_00
--
CREATE TABLE IF NOT EXISTS `spell_jump_distance` (
  `ID` int unsigned NOT NULL COMMENT 'spell id',
  `JumpDistance` float NOT NULL DEFAULT '0' COMMENT 'max hop distance in yards',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Per-spell chain jump distance override';

DELETE FROM `spell_jump_distance` WHERE `ID` IN (62131, 64390);
INSERT INTO `spell_jump_distance` (`ID`, `JumpDistance`) VALUES
(62131, 5.0),
(64390, 5.0);
