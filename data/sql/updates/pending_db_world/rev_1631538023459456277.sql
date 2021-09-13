INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631538023459456277');

-- Removed the cast of Thrash for Tamra Stormpike
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14275) AND (`source_type` = 0)

