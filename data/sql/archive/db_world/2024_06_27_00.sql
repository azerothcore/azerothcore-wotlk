-- DB update 2024_06_26_05 -> 2024_06_27_00
-- Treebole
UPDATE `creature_template_addon` SET `path_id` = 222150 WHERE (`entry` = 22215);

DELETE FROM `waypoint_data` WHERE `id` = 222150;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(222150, 1, 3609.03, 6829.57, 136.69, 5.2105, 300000, 0, 0, 100, 0),
(222150, 2, 3598.63, 6845.62, 140.703, 2.54014, 0, 0, 0, 100, 0),
(222150, 3, 3587.26, 6853.75, 141.589, 2.52051, 0, 0, 0, 100, 0),
(222150, 4, 3568.35, 6864.28, 140.533, 4.41331, 300000, 0, 0, 100, 0),
(222150, 5, 3587.72, 6853.33, 141.546, 5.70922, 0, 0, 0, 100, 0),
(222150, 6, 3599.61, 6845.15, 140.649, 5.70922, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE (`id1` = 22215 AND `guid` = 77879);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(77879, 22215, 0, 0, 530, 0, 0, 1, 1, 0, 3609.03, 6829.56, 136.69, 5.2105, 300, 0, 0, 6986, 0, 2, 0, 0, 0, '', 0, 0, NULL);
