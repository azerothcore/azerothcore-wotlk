INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638793339933122752');

-- Remove money drop from Imp Minion 12922
UPDATE `creature_template` SET `maxgold` = 0 WHERE `entry` = 12922;

