INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606545399394537100');

-- Saronite Animus 10 player and 25 player

UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83 WHERE `entry` IN (33524,34152);

-- Snobold Vassal 10 Normal & Heroic, and 25 Normal & Heroic

UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82 WHERE `entry` IN (34800,35441,35442,35443);

