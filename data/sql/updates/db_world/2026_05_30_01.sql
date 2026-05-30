-- DB update 2026_05_30_00 -> 2026_05_30_01
--
DROP TABLE IF EXISTS `spell_cone`;
CREATE TABLE `spell_cone` (
    `ID` INT UNSIGNED NOT NULL COMMENT 'Spell ID',
    `ConeDegrees` SMALLINT NOT NULL DEFAULT '60' COMMENT 'Cone angle in degrees',
    PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
