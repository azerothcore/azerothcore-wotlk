INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627896958983750100');

-- Change the spawn to 1 second so the item wont dissapear
UPDATE `gameobject` SET `spawntimesecs` = 1 WHERE `guid` IN (9986, 10135, 10030);

