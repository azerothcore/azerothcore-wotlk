-- DB update 2024_11_15_00 -> 2025_01_31_00
--
DROP TABLE IF EXISTS `world_state`;
CREATE TABLE IF NOT EXISTS `world_state` (
   `Id` INT UNSIGNED NOT NULL COMMENT 'Internal save ID',
   `Data` longtext,
   PRIMARY KEY(`Id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='WorldState save system';

-- Isle of Quel'danas is in its final stage with all subphases completed
-- open all Sunwell Plateau gates
DELETE FROM `world_state` WHERE `Id` = 20;
INSERT INTO `world_state` (`Id`, `Data`) VALUES(20, '3 15 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 3 80 80 80');
