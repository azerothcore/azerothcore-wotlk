INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615275106559909076');

-- Reset ranged attack times
UPDATE `creature_template` SET `RangeAttackTime` = 2000 WHERE `RangeAttackTime` > 0;
