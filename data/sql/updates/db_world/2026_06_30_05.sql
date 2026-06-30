-- DB update 2026_06_30_04 -> 2026_06_30_05

-- Set idle for three Winter Rumblers
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id` = 34135) AND (`guid` IN (136275, 136276, 136277));

-- Two Winter Revenants must run
UPDATE `waypoint_data` SET `move_type` = 1 WHERE (`id` IN (1362730, 1362820));

-- Add new Winter Rumblers
DELETE FROM `creature` WHERE (`id` = 34135) AND (`guid` IN (136283, 136284, 136285));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(136283, 34135, 603, 0, 0, 3, 1, 0, 1811.84, -354.296, 421.776, 0.19636, 604800, 0, 0, 195495, 81620, 0, 0, 0, 0, '', NULL, 0),
(136284, 34135, 603, 0, 0, 3, 1, 0, 1812.91, -359.363, 412.904, 0.35580, 604800, 0, 0, 195495, 81620, 0, 0, 0, 0, '', NULL, 0),
(136285, 34135, 603, 0, 0, 3, 1, 0, 1814.06, -364.178, 413.139, 0.20107, 604800, 0, 0, 195495, 81620, 0, 0, 0, 0, '', NULL, 0);

-- Set Creature Formation
DELETE FROM `creature_formations` WHERE (`LeaderGUID` IN (136272, 136273, 136282));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(136272, 136272, 0, 0, 515, 0, 0),
(136272, 136279, 10, 180, 515, 0, 0),
(136272, 136278, 10, 230, 515, 0, 0),
(136272, 136280, 10, 130, 515, 0, 0),
(136273, 136273, 0, 0, 515, 0, 0),
(136273, 136275, 6, 180, 515, 0, 0),
(136273, 136276, 12, 180, 515, 0, 0),
(136273, 136277, 18, 180, 515, 0, 0),
(136282, 136282, 0, 0, 515, 0, 0),
(136282, 136283, 6, 180, 515, 0, 0),
(136282, 136284, 12, 180, 515, 0, 0),
(136282, 136285, 18, 180, 515, 0, 0);
