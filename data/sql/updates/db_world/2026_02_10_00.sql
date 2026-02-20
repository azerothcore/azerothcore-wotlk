-- DB update 2026_02_09_00 -> 2026_02_10_00
-- Fix gameobject spawns with non-unit rotation quaternions (sniffed values)

-- Barbershop Chairs
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.66261959075927734, `rotation3` = 0.748956084251403808 WHERE `guid` = 4718;   -- 190699
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.99496841430664062, `rotation3` = 0.100189015269279479 WHERE `guid` = 4958;  -- 190697
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.83388519287109375, `rotation3` = 0.55193793773651123 WHERE `guid` = 5136;    -- 190698
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.85035133361816406, `rotation3` = 0.52621537446975708 WHERE `guid` = 5496;   -- 190704

-- Legends of the Earth (2657)
UPDATE `gameobject` SET `rotation0` = 0.177045822143554687, `rotation1` = -0.68458366394042968, `rotation2` = -0.66014003753662109, `rotation3` = 0.253407031297683715 WHERE `guid` = 12007;

-- Battered Chest (106318)
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.99965667724609375, `rotation3` = 0.026201646775007247 WHERE `guid` = 26916;
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.6883544921875, `rotation3` = 0.725374460220336914 WHERE `guid` = 85745;
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.19936752319335937, `rotation3` = 0.979924798011779785 WHERE `guid` = 85756;
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.477158546447753906, `rotation3` = 0.878817260265350341 WHERE `guid` = 85879;

-- Water Well Cleansing Aura (2904)
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.374606132507324218, `rotation3` = 0.927184045314788818 WHERE `guid` = 46424;
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.034898757934570312, `rotation3` = 0.999390840530395507 WHERE `guid` = 46425;
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.99965667724609375, `rotation3` = 0.026201646775007247 WHERE `guid` = 46429;

-- Frostwyrm Waterfall Door (181225, Naxxramas)
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.77439212799072265, `rotation3` = 0.632705986499786376 WHERE `guid` = 67868;

-- Axxarien Crystal (185056)
UPDATE `gameobject` SET `rotation0` = 0.045565605163574218, `rotation1` = 0.100982666015625, `rotation2` = 0.293343544006347656, `rotation3` = 0.949566125869750976 WHERE `guid` = 99796;

-- Cage (185474, Serpentshrine Cavern) - normalized from (0, 0, 0.7, -0.7)
UPDATE `gameobject` SET `rotation0` = 0, `rotation1` = 0, `rotation2` = -0.70710678118654752, `rotation3` = 0.70710678118654752 WHERE `guid` = 265632;
