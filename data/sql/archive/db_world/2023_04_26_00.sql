-- DB update 2023_04_24_00 -> 2023_04_26_00
DELETE FROM `creature` WHERE `id1` IN (17461, 20923) AND `guid` IN (151118, 151283);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(151283, 20923, 0, 0, 540, 0, 0, 2, 1, 1, 512.687, 315.652, 2.0405, 2.98451, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 46924),
(151118, 17461, 0, 0, 540, 0, 0, 1, 1, 1, 512.687, 315.652, 2.0405, 2.98451, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 46924);

UPDATE `creature` SET `spawntimesecs` = 86400 WHERE `map` = 540 AND `spawntimesecs` = 7200;
