-- Araga (14222)
DELETE FROM `creature_addon` WHERE (`guid` IN (17066));

DELETE FROM `creature` WHERE `guid` IN (17066, 23431, 23434);
INSERT INTO `creature` (`guid`, `id1`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `wander_distance`, `MovementType`) VALUES 
(17066, 14222, 153.893, -62.1832, 100.034, 4.13847, 95400, 1342, 50, 1),
(23431, 14222, -203.155, -308.609, 157.801, 0.395757, 95400, 1342, 50, 1),
(23434, 14222, -105.383, -85.8896, 139.728, 1.88409, 95400, 1342, 50, 1);
