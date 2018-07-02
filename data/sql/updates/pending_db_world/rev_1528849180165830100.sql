INSERT INTO version_db_world (`sql_rev`) VALUES ('1528849180165830100');


-- proper coords: 
-- 3465.16, -3940.45, 308.788, 0.441179, -0.305481, 0.637715, 0.305481, 0.637716,
-- requires two guids, one for the 'visual effect' and one for the 
-- teleporter gameobject itself

-- teleporter itself
UPDATE `gameobject` SET
    `spawnmask` = 3, `phasemask`= 1,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    where `guid` = 65857; -- check if guid is valid

-- visual effect
UPDATE `gameobject` SET
    `spawnmask` = 3, `phasemask`= 2,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    WHERE `guid` = 268045; -- check if guid is valid
