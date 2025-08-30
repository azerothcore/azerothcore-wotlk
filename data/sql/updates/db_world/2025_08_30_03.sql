-- DB update 2025_08_30_02 -> 2025_08_30_03
-- Update gameobject 'Stranglekelp Sack' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (185004)) AND (`guid` IN (25928));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(25928, 185004, 530, 0, 0, 1, 1, 728.25927734375, 6844.61083984375, -66.3580474853515625, 4.433136463165283203, 0, 0, -0.79863548278808593, 0.60181504487991333, 120, 255, 1, "", 45942, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (185004)) AND (`guid` IN (84, 85));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(84, 185004, 1, 0, 0, 1, 1, -1049.5347900390625, -290.34722900390625, 159.0303497314453125, 0.209439441561698913, 0, 0, 0.104528427124023437, 0.994521915912628173, 120, 255, 1, "", 45435, NULL),
(85, 185004, 1, 0, 0, 1, 1, -1050.2257080078125, -290.552093505859375, 159.0303497314453125, 2.495818138122558593, 0, 0, 0.948323249816894531, 0.317305892705917358, 120, 255, 1, "", 45435, NULL);
