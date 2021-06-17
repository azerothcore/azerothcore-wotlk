INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623254092348182246');

-- Delete despawn event from SmartAI of Lorgus Jett
DELETE FROM `smart_scripts` WHERE `entryorguid`=12902 AND `id`=0;
