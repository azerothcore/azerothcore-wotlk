INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612566366687490200');

-- Relocate Strange Lockbox and add Bubbly Fissure near it.

UPDATE `gameobject` SET `position_x` = 842.715, `position_y` = 2208.32, `position_z` = -136.765 WHERE `guid` = 27813;
INSERT INTO `gameobject` (`id`, `position_x`, `position_y`, `position_z`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(177524, 838.26, 2208.14, -136.906, -0.753998, -0.656877, 900, 100, 1);

