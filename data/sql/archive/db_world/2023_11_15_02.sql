-- DB update 2023_11_15_01 -> 2023_11_15_02
--
SET @CGUID := 15013;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+3;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `unit_flags`, `dynamicflags`, `CreateObject`, `VerifiedBuild`) VALUES
(@CGUID+0, 21806, 548, 3607, 3607, 1, 1, 0, 369.23431396484375, -446.472564697265625, 29.6020355224609375,  0.820574045181274414, 7200, 0, 0, 29470, 0, 0, 0, 0, 1, 52148), -- 21806 (Area: 3607 - Difficulty: 4) CreateObject1
(@CGUID+1, 21806, 548, 3607, 3607, 1, 1, 0, 385.1583251953125,  -441.596710205078125, 29.61212921142578125, 2.810055494308471679, 7200, 0, 0, 29470, 0, 0, 0, 0, 1, 52148), -- 21806 (Area: 3607 - Difficulty: 4) CreateObject1
(@CGUID+2, 21806, 548, 3607, 3607, 1, 1, 0, 373.21923828125,    -429.14776611328125,  29.60641860961914062, 5.049488067626953125, 7200, 0, 0, 29470, 0, 0, 0, 0, 1, 52148), -- 21806 (Area: 3607 - Difficulty: 4) CreateObject1
(@CGUID+3, 21215, 548, 3607, 3607, 1, 1, 0, 376.5428466796875,  -438.630889892578125, 29.60830116271972656, 2.670353651046752929, 7200, 0, 0, 0,     0, 0, 0, 0, 1, 52148); -- 21215 (Area: 3607 - Difficulty: 4) CreateObject1 (Auras: 37546 - 37546)

DELETE FROM `creature_addon` WHERE `guid` = @CGUID+3;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(@CGUID+3, 0, 0, 8, 1, '37546'); -- 21215 - 37546 - 37546

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+3;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+3, @CGUID+3, 0, 0, 24, 0, 0), 
(@CGUID+3, @CGUID+0, 0, 0, 24, 0, 0),
(@CGUID+3, @CGUID+1, 0, 0, 24, 0, 0),
(@CGUID+3, @CGUID+2, 0, 0, 24, 0, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21806) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21806, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 205, 2, 1, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - On Just Died - Do Action ID 1 (ACTION_CHECK_SPELLBINDERS)');
