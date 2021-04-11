INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617913282545327642');

-- Silverpine Forest
DELETE FROM  `gameobject` WHERE `guid`=35525;

-- Darkshore
DELETE FROM  `gameobject` WHERE `guid` in (4729, 5079, 5055, 5078, 5079, 5392, 5351);

-- Durotar
DELETE FROM  `gameobject` WHERE `guid`=12383;
