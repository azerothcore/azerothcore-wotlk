INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638113589865941888');

-- Add SAI to Deathstalker Vincent
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4444;
