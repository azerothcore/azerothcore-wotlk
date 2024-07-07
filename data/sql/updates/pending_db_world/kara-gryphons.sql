SET
@CGUID = 12554;

DELETE FROM `creature` WHERE `id1` = 17660 AND `guid` IN (135966, 135967);
DELETE FROM `creature` WHERE `id1` = 17660 AND `guid` IN (@CGUID+0, @CGUID+1);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0, 17660, 532, 3457, 3457, 1, 1, 0, -11117.73828125, -1930.064697265625, 266.5784912109375, 0.667460560798645019, 604800, 0, 0, 4890, 0, 2, 0, 0, 0, '', 51943, 1, ''),
(@CGUID+1, 17660, 532, 3457, 3457, 1, 1, 0, -11014.953125, -2033.3409423828125, 228.4856719970703125, 1.298128366470336914, 604800, 0, 0, 4890, 0, 2, 0, 0, 0, '', 51943, 1, '');

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 17660;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(17660, 0, 0, 1, 0, 0, 0, NULL);

DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+0, @CGUID+1);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+0, (@CGUID+0)*10, 0, 0, 0, 0, 0, ''),
(@CGUID+1, (@CGUID+1)*10, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` IN (((@CGUID+0)*10), ((@CGUID+1)*10));
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `action_chance`) VALUES
((@CGUID+0)*10, 1, -11098.419, -1937.0795, 278.84317, NULL, 0, 100),
((@CGUID+0)*10, 2, -11114.553, -1982.4431, 285.61502, NULL, 0, 100),
((@CGUID+0)*10, 3, -11140.832, -1980.028, 284.5932, NULL, 0, 100),
((@CGUID+0)*10, 4, -11132.868, -1950.2848, 267.4821, NULL, 0, 100),
((@CGUID+0)*10, 5, -11114.48, -1928.0963, 267.4821, NULL, 0, 100),
((@CGUID+0)*10, 6, -11098.419, -1937.0795, 278.84317, NULL, 0, 100),
((@CGUID+0)*10, 7, -11114.553, -1982.4431, 285.61502, NULL, 0, 100),
((@CGUID+0)*10, 8, -11140.832, -1980.028, 284.5932, NULL, 0, 100),

((@CGUID+1)*10, 1, -11012.726, -2061.759, 228.55539, NULL, 0, 100),
((@CGUID+1)*10, 2, -11014.861, -2033.0435, 228.55539, NULL, 0, 100),
((@CGUID+1)*10, 3, -11001.45, -2028.6311, 236.86093, NULL, 0, 100),
((@CGUID+1)*10, 4, -10998.617, -2077.8254, 237.05539, NULL, 0, 100),
((@CGUID+1)*10, 5, -11012.573, -2091.948, 243.74983, NULL, 0, 100),
((@CGUID+1)*10, 6, -11020.521, -2075.4788, 228.55539, NULL, 0, 100),
((@CGUID+1)*10, 7, -11012.726, -2061.759, 228.55539, NULL, 0, 100),
((@CGUID+1)*10, 8, -11014.861, -2033.0435, 228.55539, NULL, 0, 100),
((@CGUID+1)*10, 9, -11001.45, -2028.6311, 236.86093, NULL, 0, 100);
