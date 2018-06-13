-- proper coords: 
-- 3465.16, -3940.45, 308.788, 0.441179, -0.305481, 0.637715, 0.305481, 0.637716,
-- requires two guids, one for the 'visual effect' and one for the 
-- teleporter gameobject itself

update `gameobject` set
    `spawnmask` = 3, `phasemask`= 1,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    where `guid` in(65857); -- check if guid is valid

update `gameobject` set
    `spawnmask` = 3, `phasemask`= 2,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    where `guid` in(268045); -- check if guid is valid
