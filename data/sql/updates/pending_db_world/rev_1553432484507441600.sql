INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553432484507441600');

-- Fix Rune of Summoning
UPDATE `creature_template` SET `difficulty_entry_1`= 0 WHERE `entry`= 33051;
