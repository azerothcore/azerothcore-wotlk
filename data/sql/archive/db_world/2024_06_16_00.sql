-- DB update 2024_06_15_04 -> 2024_06_16_00
DROP TABLE IF EXISTS `creature_template_model`;
CREATE TABLE `creature_template_model`(
  `CreatureID` int unsigned NOT NULL,
  `Idx` smallint unsigned NOT NULL DEFAULT '0',
  `CreatureDisplayID` int unsigned NOT NULL,
  `DisplayScale` float NOT NULL DEFAULT '1',
  `Probability` float NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint unsigned,
  PRIMARY KEY (`CreatureID`,`Idx`),
  CONSTRAINT creature_template_model_chk_1 CHECK (`Idx` <= 3)
) ENGINE=InnoDB CHARSET=utf8mb4;

INSERT IGNORE INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `entry`,0,`modelid1`,`scale`,1,`VerifiedBuild` FROM `creature_template` WHERE `modelid1`!=0;
INSERT IGNORE INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `entry`,1,`modelid2`,`scale`,1,`VerifiedBuild` FROM `creature_template` WHERE `modelid2`!=0;
INSERT IGNORE INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `entry`,2,`modelid3`,`scale`,1,`VerifiedBuild` FROM `creature_template` WHERE `modelid3`!=0;
INSERT IGNORE INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `entry`,3,`modelid4`,`scale`,1,`VerifiedBuild` FROM `creature_template` WHERE `modelid4`!=0;

UPDATE `creature_template` SET `scale`=1;

ALTER TABLE `creature_template`
  DROP `modelid1`,
  DROP `modelid2`,
  DROP `modelid3`,
  DROP `modelid4`;
