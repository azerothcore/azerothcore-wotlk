-- DB update 2026_02_26_01 -> 2026_02_26_02
-- Update gameobject 'Huge Laying Skeleton 02' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (185458)) AND (`guid` IN (222, 223, 224, 225));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(222, 185458, 530, 0, 0, 1, 1, -3972.2392578125, 2224.816650390625, 102.3404464721679687, 0.593410074710845947, 0, 0, 0.292370796203613281, 0.95630502700805664, 120, 255, 1, "", 45942, NULL),
(223, 185458, 530, 0, 0, 1, 1, -3990.3056640625, 2148.642333984375, 104.2225723266601562, 0.139624491333961486, 0, 0, 0.06975555419921875, 0.997564136981964111, 120, 255, 1, "", 45942, NULL),
(224, 185458, 530, 0, 0, 1, 1, 2289.8935546875, 5987.240234375, 142.3500518798828125, 2.042035102844238281, 0, 0, 0.852640151977539062, 0.522498607635498046, 120, 255, 1, "", 45942, NULL),
(225, 185458, 530, 0, 0, 1, 1, 2362.826416015625, 5975.78369140625, 152.4012603759765625, 0.733038187026977539, 0, 0, 0.358367919921875, 0.933580458164215087, 120, 255, 1, "", 45942, NULL);

-- enable all spawns for eventEntry 12
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 12) AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (185458)));
INSERT INTO `game_event_gameobject` (SELECT 12, `guid` FROM `gameobject` WHERE `id` IN (185458));
