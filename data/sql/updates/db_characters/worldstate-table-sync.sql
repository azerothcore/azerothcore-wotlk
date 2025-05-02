INSERT INTO `worldstates` (`entry`, `value`) SELECT `ID`, `Data` FROM `world_state`;

DROP TABLE IF EXISTS `world_state`;
