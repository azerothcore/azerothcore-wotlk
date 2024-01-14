-- Midsummer gameobject spawn cleanups

-- 181355, 'Standing, Exterior, Medium - MFF'
-- remove remaining invalid / duplicate spawns
DELETE FROM `gameobject` WHERE (`id` = 181355) AND (`guid` IN (21016, 51362, 51652, 51766, 51767, 51868, 51938, 52045, 52048, 52186, 52205, 52213, 78503, 78504, 78505, 78507, 78508, 78509, 78510, 78511, 78512, 78513));
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (21016, 51362, 51652, 51766, 51767, 51868, 51938, 52045, 52048, 52186, 52205, 52213, 78503, 78504, 78505, 78507, 78508, 78509, 78510, 78511, 78512, 78513));

-- 181605, 'Ribbon Pole'
-- manually add one missing spawn
DELETE FROM `gameobject` WHERE (`id` = 181605) AND (`guid` = 5);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(5, 181605, 571, 0, 0, 1, 1, 6163.2705078125, -1033.99853515625, 409.246368408203 , 5.777040958404541015, 0, 0, 0, 0, 120, 255, 1, "", 0, NULL);
