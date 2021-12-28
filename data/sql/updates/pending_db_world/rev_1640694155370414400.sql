INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640694155370414400');

-- High Marshal Whirlaxis unit flags: UNK_6 & IMMUNE_TO_PC
UPDATE `acore_world`.`creature_template` SET `unit_flags`='320' WHERE  `entry` = 15204;
