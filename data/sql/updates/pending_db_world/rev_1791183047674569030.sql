--
SET @SKARTAX := 21207;
SET @SOUL := 19757;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@SKARTAX, @SOUL) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @SOUL*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SKARTAX, 0, 0, 1, 1, 0, 100, 0, 0, 0, 5000, 5000, 0, 0, 11, 36382, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Spawn - Cast Skartax Self Aura I'),
(@SKARTAX, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - On Spawn - Cast Test Channel'),
(@SKARTAX, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3000, 5000, 0, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - IC - Cast Shadowbolt'),
(@SKARTAX, 0, 3, 0, 0, 0, 100, 0, 0, 0, 2500, 4500, 0, 0, 11, 38401, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoner Skartax - IC - Cast Incinerate'),
(@SKARTAX, 0, 4, 0, 1, 0, 100, 0, 13000, 13000, 139000, 139000, 0, 0, 12, @SOUL, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -3368.91, 2145.37, -8.39026, 4.4855, 'Summoner Skartax - Out of Combat - Summon Creature ''Infernal Soul'''),
(@SOUL, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 15000, 20000, 0, 0, 11, 11969, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - In Combat - Cast ''11969'''),
(@SOUL, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, @SOUL, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Just Summoned - Start Waypoint'),
(@SOUL, 0, 2, 0, 40, 0, 100, 0, 30, @SOUL, 0, 0, 0, 0, 80, @SOUL*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Waypoint 30 Reached - Run Script'),
(@SOUL*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 11969, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Cast ''Fire Nova'''),
(@SOUL*100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infernal Soul - On Script - Cast ''Suicide''');

DELETE FROM `waypoints` WHERE `entry` = @SOUL;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@SOUL, 1, -3354.03, 2136.07, -7.61769, 'Infernal Soul'),
(@SOUL, 2, -3334.71, 2123.35, 0.11053, 'Infernal Soul'),
(@SOUL, 3, -3336.44, 2118.74, 2.38597, 'Infernal Soul'),
(@SOUL, 4, -3350.58, 2102.4, 6.41464, 'Infernal Soul'),
(@SOUL, 5, -3361.74, 2090.76, 4.97179, 'Infernal Soul'),
(@SOUL, 6, -3372.55, 2080.44, 6.92308, 'Infernal Soul'),
(@SOUL, 7, -3390.73, 2071.64, 9.47893, 'Infernal Soul'),
(@SOUL, 8, -3397.3, 2062.29, 14.806, 'Infernal Soul'),
(@SOUL, 9, -3403.15, 2057.08, 15.1465, 'Infernal Soul'),
(@SOUL, 10, -3403.51, 2050.05, 17.1691, 'Infernal Soul'),
(@SOUL, 11, -3401.42, 2042.17, 20.6853, 'Infernal Soul'),
(@SOUL, 12, -3398.08, 2022.91, 20.7692, 'Infernal Soul'),
(@SOUL, 13, -3394.88, 2001.23, 24.7175, 'Infernal Soul'),
(@SOUL, 14, -3395.34, 1996.95, 24.8946, 'Infernal Soul'),
(@SOUL, 15, -3391.31, 1990.31, 25.4022, 'Infernal Soul'),
(@SOUL, 16, -3374.79, 1986.2, 24.7703, 'Infernal Soul'),
(@SOUL, 17, -3361.02, 1986.22, 27.7904, 'Infernal Soul'),
(@SOUL, 18, -3352.33, 1994.87, 30.4105, 'Infernal Soul'),
(@SOUL, 19, -3347.76, 2002.66, 32.189, 'Infernal Soul'),
(@SOUL, 20, -3345.88, 2009.09, 32.6195, 'Infernal Soul'),
(@SOUL, 21, -3347.41, 2015.16, 33.8197, 'Infernal Soul'),
(@SOUL, 22, -3355.96, 2028.38, 35.8015, 'Infernal Soul'),
(@SOUL, 23, -3366.47, 2041.37, 38.7981, 'Infernal Soul'),
(@SOUL, 24, -3375.81, 2054.35, 35.7529, 'Infernal Soul'),
(@SOUL, 25, -3386.45, 2085.32, 34.3794, 'Infernal Soul'),
(@SOUL, 26, -3408.12, 2107.9, 34.3787, 'Infernal Soul'),
(@SOUL, 27, -3432.92, 2130.66, 34.4017, 'Infernal Soul'),
(@SOUL, 28, -3447.56, 2143.64, 31.5217, 'Infernal Soul'),
(@SOUL, 29, -3468.23, 2160.36, 33.164, 'Infernal Soul'),
(@SOUL, 30, -3477.01, 2171.72, 32.9352, 'Infernal Soul');
