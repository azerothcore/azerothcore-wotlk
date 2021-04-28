INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619636650124390405');

DELETE FROM `waypoint_data` WHERE `id` IN (139910, 139920);
DELETE FROM `creature_addon` WHERE (`guid` IN (13991, 13992));

DELETE FROM `creature` WHERE (`id` = 3397) AND (`guid` IN (13991, 13992));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(13991, 3397, 1, 0, 0, 1, 1, 9447, 1, -1168.06, -2040.54, 92.2584, 0.481264, 275, 0, 1, 235, 295, 0, 0, 0, 0, '', 0),
(13992, 3397, 1, 0, 0, 1, 1, 9447, 1, -1168.91, -2043.24, 92.2584, 0.481511, 275, 0, 1, 235, 295, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=13990;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(13990,13990,0,0,515,0,0),
(13990,13991,3,80,515,0,0),
(13990,13992,3,280,515,0,0);
