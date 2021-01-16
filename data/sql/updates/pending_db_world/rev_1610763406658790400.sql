INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610763406658790400');

DROP TABLE IF EXISTS `cinematiccamera_dbc`; 
CREATE TABLE `cinematiccamera_dbc` 
(
  `ID` INT NOT NULL DEFAULT '0',
  `model` varchar(100) NULL,
  `soundEntry` INT NOT NULL DEFAULT '0',
  `locationX` FLOAT NOT NULL DEFAULT '0',
  `locationY` FLOAT NOT NULL DEFAULT '0',
  `locationZ` FLOAT NOT NULL DEFAULT '0',
  `rotation` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Cinematic camera DBC';

