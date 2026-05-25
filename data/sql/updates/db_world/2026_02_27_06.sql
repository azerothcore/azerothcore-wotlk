-- DB update 2026_02_27_05 -> 2026_02_27_06
-- Update gameobject 'unnamed yellow dome' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (193796, 193795)) AND (`guid` IN (268695, 268770));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(268695, 193796, 571, 0, 0, 1, 1, 7628.9599609375, 2060.48779296875, 586.426513671875, 3.703464746475219726, 0, 0, -0.96079635620117187, 0.277255088090896606, 120, 255, 1, "", 45942, NULL),
(268770, 193795, 571, 0, 0, 1, 1, 7888.88037109375, 2058.36279296875, 586.39581298828125, 3.729639530181884765, 0, 0, -0.95708560943603515, 0.289805322885513305, 120, 255, 1, "", 45942, NULL);
