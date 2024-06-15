-- DB update 2022_07_20_09 -> 2022_07_20_10
--
/* Snakes */
UPDATE `creature` SET `id1`=11371 WHERE `guid` IN (49096, 49097);
UPDATE `creature` SET `id2`=11372 WHERE `guid` IN (49096, 49097);

/* Priest can be Axe thrower */
UPDATE `creature` SET `id2`=11350 WHERE  `guid`=49754;

/* Crocs movement is a scripted action that occurs about every 30 seconds, and all crocs do it--not normal random movement */
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `id1`=15043;

/* Reposition a Snake */
/* Reposition two Trolls */
DELETE FROM `creature` WHERE `guid` IN (49121, 49122, 49097);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49097, 11371, 11372, 0, 309, 0, 0, 1, 1, 0, -11959.5, -1547.96, 40.6727, 3.1776, 7200, 0, 0, 15260, 0, 0, 0, 0, 0, '', 0),
(49121, 11351, 0, 0, 309, 0, 0, 1, 1, 1, -12008.5, -1484.79, 79.1498, 4.87654, 7200, 0, 0, 21364, 0, 0, 0, 0, 0, '', 0),
(49122, 11831, 0, 0, 309, 0, 0, 1, 1, 1, -12004.5, -1483.46, 79.5746, 4.71553, 7200, 0, 0, 24420, 12170, 0, 0, 0, 0, '', 0);

/* Movetype and wander distance corrections for Snakes and Bats/Bat Riders */
UPDATE `creature` SET `wander_distance`=2, `MovementType`=1 WHERE  `guid` IN (49096, 49097, 49190, 49191, 49192, 49193);
