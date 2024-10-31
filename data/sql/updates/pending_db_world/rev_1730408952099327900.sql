-- Update gameobject 'Pilgrim's Bounty Cooking Fire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (195200))
AND (`guid` IN (240448, 240473, 240517, 240549, 240766, 240830, 240913));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(240448, 195200, 0, 0, 0, 1, 1, -9113.81640625, 361.357635498046875, 93.56732940673828125, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL),
(240473, 195200, 1, 0, 0, 1, 1, 9993.107421875, 2230.94091796875, 1330.155029296875, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL),
(240517, 195200, 530, 0, 0, 1, 1, -4002.55908203125, -11840.4267578125, 0.227538004517555236, 2.757613182067871093, 0, 0, 0.981626510620117187, 0.190812408924102783, 120, 255, 1, "", 46368, NULL),
(240549, 195200, 1, 0, 0, 1, 1, 1321.7413330078125, -4417.61962890625, 26.74661827087402343, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL),
(240766, 195200, 1, 0, 0, 1, 1, -1339.1910400390625, 198.078125, 60.31057357788085937, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL),
(240830, 195200, 0, 0, 0, 1, 1, 1824.7725830078125, 268.177093505859375, 60.24002456665039062, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL),
(240913, 195200, 530, 0, 0, 1, 1, 9303.623046875, -7252.99462890625, 14.25869560241699218, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (195200))
AND (`guid` IN (30));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(30, 195200, 0, 0, 0, 1, 1, -5066.08837890625, -804.046875, 495.11627197265625, 0, 0, 0, 0, 1, 120, 255, 1, "", 46368, NULL);

-- enable all spawns for eventEntry 26
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 26)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (195200)));
INSERT INTO `game_event_gameobject` (SELECT 26, `guid` FROM `gameobject` WHERE `id` IN (195200));
