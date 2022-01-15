INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642261371882755981');

DELETE FROM `creature` WHERE (`guid` IN (248595, 248596, 248597, 248598, 248599, 248600));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(248595, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -79.4547, -523.615, 82.6267, 0.80285, 7200, 0, 0, 10633, 0, 0, 0, 0, 0, '', 0),
(248596, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -56.9907, -427.546, 77.8323, 1.44862, 7200, 0, 0, 8883, 0, 0, 0, 0, 0, '', 0),
(248597, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -20.5394, -390.931, 48.5351, 3.01552, 10800, 0, 0, 10633, 0, 0, 0, 0, 0, '', 0),
(248598, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -22.0032, -343.162, 31.6102, 5.37632, 10800, 0, 0, 10633, 0, 0, 0, 0, 0, '', 0),
(248599, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -40.7202, -361.08, 31.6183, 4.6267, 10800, 0, 0, 10633, 0, 0, 0, 0, 0, '', 0),
(248600, 9216, 0, 0, 229, 0, 0, 1, 1, 0, -31.6468, -380.597, 31.6183, 4.68053, 10800, 0, 0, 10633, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_formations` WHERE (`leaderGUID` IN (24181, 248595));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES 
(248595, 248595, 0, 0, 3),
(248595, 52124, 0, 0, 3),
(248595, 42188, 0, 0, 3);
