INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622719475133710519');

-- unused GUIDs
SET @GOB1 := 64811;
SET @GOB2 := 64827;
SET @GOB3 := 64837;
SET @GOB4 := 64839;
SET @GOB5 := 64843;
SET @GOB6 := 64859;
SET @POOL1:= 364;
SET @POOL2 := 387;

DELETE FROM `gameobject` WHERE `id` = 180753 AND `guid` IN (@GOB1, @GOB2, @GOB3, @GOB4, @GOB5, @GOB6);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `spawntimesecs`, `animprogress`) VALUES
(64811, 180753, 1, 3638.1101, -6042.0297, 3600, 100),
(64827, 180753, 1, 3993.8320, -6058.8184, 3600, 100),
(64837, 180753, 1, 3966.5193, -6337.3110, 3600, 100),
(64839, 180753, 1, 3551.7053, -7292.4677, 3600, 100),
(64843, 180753, 1, 2892.4980, -7080.7880, 3600, 100),
(64859, 180753, 1, 3025.6696, -6657.1953, 3600, 100);

DELETE FROM `pool_template` WHERE `entry` = @POOL1;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL1, 4, 'Azshara - Patch of Elemental Water');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@GOB1, @GOB2, @GOB3, @GOB4, @GOB5, @GOB6);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(64811, @POOL1, 0, '1 - Patch of Elemental Water'),
(64827, @POOL1, 0, '2 - Patch of Elemental Water'),
(64837, @POOL1, 0, '3 - Patch of Elemental Water'),
(64839, @POOL1, 0, '4 - Patch of Elemental Water'),
(64843, @POOL1, 0, '5 - Patch of Elemental Water'),
(64859, @POOL1, 0, '6 - Patch of Elemental Water');

DELETE FROM `pool_template` WHERE `entry` = @POOL2;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL2, 1, 'Azshara - Various Fishing Nodes');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@GOB1, 48232);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(64811, @POOL2, 0, '1 - Patch of Elemental Water'),
(48232, @POOL2, 0, '2 - Floating Wreckage');
