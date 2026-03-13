-- DB update 2024_11_06_05 -> 2024_11_06_06
-- Update gameobject 'Lauranna's Guide to Zangarmarsh Plants' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (182066))
AND (`guid` IN (32));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(32, 182066, 530, 0, 0, 1, 1, -216.416015625, 5441.63818359375, 22.15843963623046875, 4.101525306701660156, 0, 0, -0.88701057434082031, 0.461749136447906494, 120, 255, 1, "", 45704, NULL);
