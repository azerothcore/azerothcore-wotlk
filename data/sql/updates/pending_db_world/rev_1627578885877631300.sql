INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627578885877631300');

-- ID changed to match the rest of the moonwells
UPDATE `gameobject_template` SET `displayId` = 1407 WHERE (`entry` = 177272);
-- Added the 4 nodes, but underground so nobody can see them
DELETE FROM `gameobject` WHERE (`id` = 177272);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(42910, 177272, 0, 0, 0, 1, 1, -8755.33, 1103.32, 91.2695, 5.13337, 0, 0, 0.543759, -0.839242, 120, 100, 1, '', 0),
(42909, 177272, 0, 0, 0, 1, 1, -8759.24, 1111.3, 91.6899, 2.2321, 0, 0, 0.898373, 0.439233, 120, 100, 1, '', 0),
(42908, 177272, 0, 0, 0, 1, 1, -8760.01, 1106.03, 91.7206, 3.34736, 0, 0, 0.994712, -0.102705, 120, 100, 1, '', 0),
(42907, 177272, 0, 0, 0, 1, 1, -8753.33, 1106.74, 91.2191, 5.7876, 0, 0, 0.245266, -0.969456, 120, 100, 1, '', 0),
(49711, 177272, 1, 0, 0, 1, 1, 9727.51, 962.386, 1293.19, -0.148352, 0, 0, -0.074108, 0.99725, 900, 100, 1, '', 0);

