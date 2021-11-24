INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637473250058502604');

DROP TABLE IF EXISTS `playercreateinfo_cast_spell`;
CREATE TABLE IF NOT EXISTS `playercreateinfo_cast_spell` (
    `raceMask` INT UNSIGNED NOT NULL DEFAULT '0',
    `classMask` INT UNSIGNED NOT NULL DEFAULT '0',
    `spell` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
    `note` VARCHAR DEFAULT NULL
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

DELETE FROM `playercreateinfo_cast_spell` WHERE `spell` IN (48266, 2457);
INSERT INTO `playercreateinfo_cast_spell` (`racemask`, `classmask`, `spell`, `note`) VALUES
(0, 32, 48266, 'Death Knight - Blood Presence'),
(0, 1, 2457, 'Warrior - Battle Stance');
