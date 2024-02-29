-- Update gameobject 'Barber Chair' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (191817))
AND (`guid` IN (504, 505));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(504, 191817, 530, 0, 0, 1, 1, 2969.0859375, 1773.8885498046875, 139.6904144287109375, 5.365918159484863281, 0, 0, -0.44272327423095703, 0.896658301353454589, 120, 255, 1, "", 45704, NULL),
(505, 191817, 530, 0, 0, 1, 1, 2969.6787109375, 3752.763427734375, 144.5045928955078125, 1.998400807380676269, 0, 0, 0.841038703918457031, 0.540974974632263183, 120, 255, 1, "", 45704, NULL);
