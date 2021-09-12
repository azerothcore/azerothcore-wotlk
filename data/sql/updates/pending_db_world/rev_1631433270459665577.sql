INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631433270459665577');

-- Remove respawn timer from Shipment of Iron
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `id` = 1736 AND `guid` = 20778;

