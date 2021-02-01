INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610987194142626485');

-- The Scarlet Key from Doan's Strongbox in the Scarlet Monastery Library should be lootable by all

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=32247;
