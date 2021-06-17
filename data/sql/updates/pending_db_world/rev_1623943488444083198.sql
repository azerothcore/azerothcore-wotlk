INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623943488444083198');

-- Remove Claw (cat ability and sound) from Mottled Raptor SmartAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=1020 AND `id`=0;
