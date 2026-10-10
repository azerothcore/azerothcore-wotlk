-- DB update 2026_10_10_12 -> 2026_10_10_13
--
SET @SKARTAX := 21207;
SET @SOUL := 19757;
SET @TINKERER := 19754;
SET @INFERNAL := 19760;
SET @PATH := 1975400;

-- Summoner Skartax: summon the soul and two Tinkerers, one stored list per summon
DELETE FROM `smart_scripts` WHERE `entryorguid` = @SKARTAX AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @SKARTAX*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SKARTAX, 0, 0, 1, 1, 0, 100, 0, 0, 0, 5000, 5000, 0, 0, 11, 36382, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Spawn - Cast Skartax Self Aura I'),
(@SKARTAX, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Spawn - Cast Test Channel'),
(@SKARTAX, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3000, 5000, 0, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - IC - Cast Shadowbolt'),
(@SKARTAX, 0, 3, 0, 0, 0, 100, 0, 0, 0, 2500, 4500, 0, 0, 11, 38401, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - IC - Cast Incinerate'),
(@SKARTAX, 0, 4, 0, 1, 0, 100, 0, 13000, 13000, 200000, 280000, 0, 0, 80, @SKARTAX*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - Out of Combat - Run Script'),
(@SKARTAX, 0, 5, 0, 17, 0, 100, 0, @SOUL, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Summoned Unit ''Infernal Soul'' - Store Targetlist 1'),
(@SKARTAX, 0, 6, 0, 17, 1, 100, 0, @TINKERER, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Summoned Unit ''Deathforge Tinkerer'' (Phase 1) - Store Targetlist 2'),
(@SKARTAX, 0, 7, 0, 17, 2, 100, 0, @TINKERER, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Summoned Unit ''Deathforge Tinkerer'' (Phase 2) - Store Targetlist 3'),
(@SKARTAX*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36330, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Cast ''Infuse Infernal Soul'''),
(@SKARTAX*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, @SOUL, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -3369.1558, 2145.255, -8.202757, 5.6548667, 'Summoner Skartax - On Script - Summon Creature ''Infernal Soul'''),
(@SKARTAX*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Set Event Phase 1'),
(@SKARTAX*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, @TINKERER, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -3347.306, 2100.1748, 5.7023654, 2.2863812, 'Summoner Skartax - On Script - Summon Creature ''Deathforge Tinkerer'' (leader)'),
(@SKARTAX*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Set Event Phase 2'),
(@SKARTAX*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, @TINKERER, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -3352.2969, 2106.8235, 7.1759396, 5.7944932, 'Summoner Skartax - On Script - Summon Creature ''Deathforge Tinkerer'' (follower)'),
(@SKARTAX*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Set Event Phase 0'),
(@SKARTAX*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Send Targetlist 1 (soul) To Leader Tinkerer'),
(@SKARTAX*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Send Targetlist 2 (leader) To Follower Tinkerer'),
(@SKARTAX*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Send Targetlist 2 (leader) To Infernal Soul'),
(@SKARTAX*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Script - Send Targetlist 3 (follower) To Infernal Soul');

-- Infernal Soul: run to the ramp foot, start the Tinkerers, follow the leader, infuse the Cooling Infernal at the end
DELETE FROM `smart_scripts` WHERE `entryorguid` = @SOUL AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @SOUL*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SOUL, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 15000, 20000, 0, 0, 11, 11969, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - In Combat - Cast ''11969'''),
(@SOUL, 0, 1, 2, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Just Summoned - Set Run On'),
(@SOUL, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -3345.083, 2102.3362, 5.2215433, 0, 'Infernal Soul - On Just Summoned - Move To Ramp Foot'),
(@SOUL, 0, 3, 4, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Reached Point 1 - Do Action 1 On Targetlist 2 (leader)'),
(@SOUL, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Reached Point 1 - Do Action 2 On Targetlist 3 (follower)'),
(@SOUL, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Reached Point 1 - Set Run Off'),
(@SOUL, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 3, 270, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Reached Point 1 - Follow Targetlist 2 (leader)'),
(@SOUL, 0, 7, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 80, @SOUL*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Action 3 Done - Run Script'),
(@SOUL*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36330, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Cast ''Infuse Infernal Soul'''),
(@SOUL*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, @INFERNAL, 8, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Do Action 1 On Closest Cooling Infernal'),
(@SOUL*100, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 86, 7, 2, 12, 2, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Leader Tinkerer Cast ''Suicide'''),
(@SOUL*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 7, 2, 12, 3, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Follower Tinkerer Cast ''Suicide'''),
(@SOUL*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Cast ''Suicide''');

-- Deathforge Tinkerer: the new rows only react to actions from the soul, the spawned Tinkerers never get them
DELETE FROM `smart_scripts` WHERE `entryorguid` = @TINKERER AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TINKERER, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 15000, 30000, 0, 0, 11, 38107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - Out of Combat - Cast ''Create Deathforge Mine'' (Phase 4) (No Repeat)'),
(@TINKERER, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 15000, 30000, 0, 0, 11, 38107, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - In Combat - Cast ''Create Deathforge Mine'' (Phase 4) (No Repeat)'),
(@TINKERER, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 10000, 15000, 0, 0, 11, 38753, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - In Combat - Cast ''Shrapnel Bomb'' (Phase 4) (No Repeat)'),
(@TINKERER, 0, 3, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, @PATH, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - On Action 1 Done - Start Waypoint (leader)'),
(@TINKERER, 0, 4, 0, 109, 0, 100, 0, 0, @PATH, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - On Waypoint Path Ended - Do Action 3 On Targetlist 1 (soul)'),
(@TINKERER, 0, 5, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 29, 3, 180, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathforge Tinkerer - On Action 2 Done - Follow Targetlist 2 (leader)');

-- Cooling Infernal: the soul wakes it, it roars and gets replaced
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @INFERNAL;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @INFERNAL AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @INFERNAL*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@INFERNAL, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, @INFERNAL*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cooling Infernal - On Action 1 Done - Run Script'),
(@INFERNAL*100, 9, 0, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cooling Infernal - On Script - Play Emote ''OneShotRoar'''),
(@INFERNAL*100, 9, 1, 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cooling Infernal - On Script - Force Despawn (respawn in 1 s)');

-- Leader Tinkerer path, the destinations are identical in every sniffed run
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`) VALUES
(@PATH, 1, -3363.5613, 2087.638, 5.290408, 0, 0),
(@PATH, 2, -3371.314, 2080.033, 6.5435963, 0, 0),
(@PATH, 3, -3388.6116, 2075.0847, 8.611635, 0, 0),
(@PATH, 4, -3395.4478, 2072.6511, 10.226436, 0, 0),
(@PATH, 5, -3395.729, 2067.5266, 13.110374, 0, 0),
(@PATH, 6, -3399.0564, 2061.214, 14.8794155, 0, 0),
(@PATH, 7, -3402.1067, 2052.118, 16.027676, 0, 0),
(@PATH, 8, -3403.7488, 2045.2952, 19.28094, 0, 0),
(@PATH, 9, -3401.6843, 2037.8613, 20.819016, 0, 0),
(@PATH, 10, -3396.9888, 2022.5807, 20.682514, 0, 0),
(@PATH, 11, -3393.949, 2008.8676, 23.384623, 0, 0),
(@PATH, 12, -3394.6797, 1998.5131, 24.746553, 0, 0),
(@PATH, 13, -3395.452, 1991.9056, 25.977041, 0, 0),
(@PATH, 14, -3376.8652, 1986.1415, 24.809105, 0, 0),
(@PATH, 15, -3363.336, 1987.5226, 27.828882, 0, 0),
(@PATH, 16, -3352.8772, 1995.1384, 30.39341, 0, 0),
(@PATH, 17, -3347.0828, 2006.181, 32.402157, 0, 0),
(@PATH, 18, -3344.879, 2012.1292, 33.09748, 0, 0),
(@PATH, 19, -3349.1606, 2017.9258, 34.09987, 0, 0),
(@PATH, 20, -3351.424, 2022.4861, 34.504448, 0, 0),
(@PATH, 21, -3356.1235, 2028.8488, 35.88413, 0, 0),
(@PATH, 22, -3361.05, 2035.6632, 37.296856, 0, 0),
(@PATH, 23, -3367.57, 2042.0217, 38.507828, 0, 0),
(@PATH, 24, -3371.233, 2049.7478, 37.08484, 0, 0),
(@PATH, 25, -3376.5781, 2061.0056, 35.009766, 0, 0),
(@PATH, 26, -3380.4841, 2069.2056, 34.376663, 0, 0),
(@PATH, 27, -3387.7454, 2086.394, 34.420708, 0, 0),
(@PATH, 28, -3399.4714, 2098.581, 34.387093, 0, 0),
(@PATH, 29, -3417.7715, 2115.6724, 34.405228, 0, 0),
(@PATH, 30, -3428.8584, 2126.1047, 34.408363, 0, 0),
(@PATH, 31, -3447.1177, 2143.6868, 31.510735, 0, 0),
(@PATH, 32, -3450.7458, 2145.7075, 31.671309, 0, 0),
(@PATH, 33, -3457.0146, 2151.0908, 32.4624, 0, 0),
(@PATH, 34, -3466.8513, 2158.7126, 32.861115, 0, 0),
(@PATH, 35, -3475.4717, 2170.6887, 32.816, 0, 0);
