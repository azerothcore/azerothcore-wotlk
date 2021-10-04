INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632745513721786346');

-- Enable swimming for Tooga
UPDATE `creature_template` SET `InhabitType` = `InhabitType`|1|2 WHERE `entry` = 5955;

