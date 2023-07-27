-- DB update 2023_07_26_04 -> 2023_07_27_00
-- path of Garn Mathers
SET @NPC := 30758 * 10; -- Garn mathers GUID * 10
DELETE FROM `waypoint_data` WHERE `id` = @NPC;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@NPC, 1, -3050.0679, -4329.487, 8.319094, 0),
(@NPC, 2, -3044.8179, -4326.487, 7.819094, 0),
(@NPC, 3, -3036.245, -4321.0723, 7.388595, 0),
(@NPC, 4, -3023.495, -4328.3223, 7.888595, 0),
(@NPC, 5, -3007.757, -4334.8223, 6.9061613, 0),
(@NPC, 6, -2997.757, -4344.0723, 6.6561613, 0),
(@NPC, 7, -2981.6763, -4353.217, 8.946001, 0),
(@NPC, 8, -2970.2686, -4358.55, 10.112873, 0),
(@NPC, 9, -2972.253, -4368.476, 9.980476, 0),
(@NPC, 10, -2983.7305, -4381.0786, 10.497398, 0),
(@NPC, 11, -3000.9695, -4383.346, 10.6955185, 0),
(@NPC, 12, -3011.9897, -4373.612, 9.795075, 0),
(@NPC, 13, -3023.2007, -4366.656, 10.3360815, 0),
(@NPC, 14, -3026.9507, -4364.906, 10.0860815, 0),
(@NPC, 15, -3040.5425, -4358.04, 8.381775, 0),
(@NPC, 16, -3048.0571, -4343.4937, 8.053871, 0);

DELETE FROM `creature` WHERE `id1` = 23679 AND `guid` = 30758;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(30758, 23679, 0, 0, 1, 0, 0, 1, 1, 1, -3050.214, -4329.639, 8.156482, 1.730132341384887695, 180, 0, 0, 1536, 0, 2, 0, 0, 0, '', 50375);

DELETE FROM `creature_addon` WHERE `guid` = 30758;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30758, @NPC, 0, 0, 1, 0, 0, '');
