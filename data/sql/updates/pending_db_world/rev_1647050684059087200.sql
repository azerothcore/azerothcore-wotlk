INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647050684059087200');

-- Remove scripts for Sha'ni Proudtusk Remains gameobject 
DELETE FROM `smart_scripts` WHERE `entryorguid` = 160445;
DELETE FROM `conditions` WHERE `SourceEntry` = 160445;
