-- Force-Commander Gorax
UPDATE `creature_template_addon` SET `path_id` = 1926400 WHERE `entry` = 19264;

DELETE FROM `creature` WHERE `guid` = 68832 AND `id1` = 19264;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(68832, 19264, 0, 0, 530, 0, 0, 1, 1, 1, -222.317, 3098.66, -60.229, 3.73311, 300, 0, 0, 22108, 0, 0, 0, 0, 0, '', 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`=1926400;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1926400, 1, -223.712, 3100.36, -60.479, 100, 0, 0, 0, 100, 0),
(1926400, 2, -245.299, 3083.23, -64.9508, 100, 0, 0, 0, 100, 0);
