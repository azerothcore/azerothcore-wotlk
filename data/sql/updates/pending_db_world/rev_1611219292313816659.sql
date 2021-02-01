INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611219292313816659');

-- The Damaged Chest from the warlock quest Tome of the Cabal should respawn right away

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=12699;
