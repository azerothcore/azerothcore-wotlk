-- DB update 2025_10_04_05 -> 2025_10_04_06
-- Update gameobject 'Doodad_Nox_portal_top01' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (191542)) AND (`guid` IN (57145, 57146));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(57145, 191542, 571, 0, 0, 1, 1, 6175.19140625, -2017.2734375, 241.0088348388671875, 2.312558174133300781, 0, 0, 0.915310859680175781, 0.402748137712478637, 120, 255, 1, "", 48019, NULL),
(57146, 191542, 571, 0, 0, 1, 1, 5171.69140625, -1666.64453125, 242.7811279296875, 2.888511419296264648, 0, 0, 0.99200439453125, 0.126203224062919616, 120, 255, 1, "", 46368, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (191542, 192613)) AND (`guid` IN (149, 150));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(149, 191542, 571, 0, 0, 1, 1, 2418.4443359375, 6456.0224609375, 50.21396255493164062, 1.608663797378540039, 0, 0, 0.720367431640625, 0.693592667579650878, 120, 255, 1, "", 45772, NULL),
(150, 192613, 571, 0, 0, 1, 1, 3669.799072265625, -1269.822021484375, 251.2554931640625, 2.404482841491699218, 0, 0, 0.932848930358886718, 0.360267788171768188, 120, 255, 1, "", 45854, NULL);
