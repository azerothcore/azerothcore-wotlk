-- DB update 2025_08_30_01 -> 2025_08_30_02
-- Update gameobject 'Mag'har Rug' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (182257)) AND (`guid` IN (22684, 22685, 22686));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(22684, 182257, 530, 0, 0, 1, 1, -1235.0460205078125, 7247.54248046875, 57.33856201171875, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 120, 255, 1, "", 45704, NULL),
(22685, 182257, 530, 0, 0, 1, 1, -1242.7056884765625, 7246.685546875, 57.29010009765625, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 120, 255, 1, "", 45704, NULL),
(22686, 182257, 530, 0, 0, 1, 1, -1238.972412109375, 7247.02001953125, 57.3078765869140625, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 120, 255, 1, "", 45704, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (182257)) AND (`guid` IN (38));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(38, 182257, 1, 0, 0, 1, 1, -1049.82470703125, -286.196197509765625, 159.0303497314453125, 2.548179388046264648, 0, 0, 0.956304550170898437, 0.292372345924377441, 120, 255, 1, "", 45435, NULL);
