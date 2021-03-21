INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616365804921648471');

-- Update Incorrect spawn of Tin Vein in the Barrens
UPDATE `gameobject` set `position_z`=94.7714 where `guid` = 5649;

-- Delete wrong spam Silver Vein in Ashenvale
DELETE FROM `gameobject` WHERE `guid` in (5708, 5710, 5711, 5712, 5713);

-- Swamp of Sorrows fix spawn
DELETE FROM `gameobject` WHERE `guid` in (32756, 6629, 30348);

-- Western Plaguelands fix spawn
DELETE FROM `gameobject` WHERE `guid` in (45552, 45561, 45502, 5816, 7193, 63994, 9641, 5770, 5944);

-- Arathi Hinterlands fix spawn
DELETE FROM `gameobject` WHERE `guid` in (70262, 70263, 70264, 70265, 70266, 70267);
DELETE FROM `gameobject` WHERE `guid` in (63520, 65233);

-- Searing Gorge fix spawn
DELETE FROM `gameobject` WHERE `guid` in (13216, 64839, 56790, 64843, 65291);
