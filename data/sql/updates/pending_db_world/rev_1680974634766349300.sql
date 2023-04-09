--
DELETE FROM `creature` WHERE `map` = 540 AND `id1` IN (20923,16507,16594,16699,16700,16704,16807,16808,16809,17083,17420,17427,17461,17464,17465,17669,17670,17694,17671,16593,17695,17622,17356,17357,17474,17301,17578) AND `guid` IN (34038,57220,57221,57222,57223,57581,57582,57583,57584,57686,57687,57688,57689,57690,57691,57692,57693,57694,57695,57696,57698,57699,57700,57853,57854,57855,59474,59475,59476,59477,62864,62865,62866,62867,62871,62872,62873,62921,62934,62935,62936,62937,62938,62939,62940,62941,62942,62943,62944,62945,62946,62947,62948,62949,62952,62953,62954,62955,63390,63391,63392,63446,63447,85746,85747,85748,85749,85750,85751,85752,85753,86366,86368,86369,86370,86423,86427,86452,86453,86454,86455,86456,86457,86458,86459,86460,86461,86462,86463,86464,86465,86466,1971542,1971543,1971544,1971545,1971546,1971547,1971548,1971549,1971550,1971551,1971552,1971553,1971554,1971555,1971556,1971557,1971558,1971559,1971560,1971561,1971562,1971563,1971564,1971565,1971566,1971567,1971568,1971569,1971570,1971571,1971572,1971573,1971574,1971575,1971576,1971580,2000102,2000103,2000104,2000105,2000106,2000107);

SET @CGUID := 151000;

DELETE FROM `creature` WHERE `map` = 540 AND `zoneId` = 3714 AND `guid` BETWEEN @CGUID+0 AND @CGUID+18;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
-- Entrance Hallway
(@CGUID+0, 17420, 540, 3714, 3714, 3, 1, 59.46694183349609375, 55.7273406982421875, -13.2002639770507812, 5.650152206420898437, 7200, 0, 0, 48966),
(@CGUID+1, 17420, 540, 3714, 3714, 3, 1, 56.37400436401367187, 57.27612686157226562, -13.1592693328857421, 6.029743671417236328, 7200, 0, 0, 48966),
(@CGUID+2, 17420, 540, 3714, 3714, 3, 1, 80.7486724853515625, 55.87627792358398437, -13.1460113525390625, 3.580806493759155273, 7200, 0, 0, 48966),
(@CGUID+3, 17420, 540, 3714, 3714, 3, 1, 84.95555877685546875, 56.459991455078125, -13.129836082458496, 3.484712839126586914, 7200, 0, 0, 48966),
(@CGUID+4, 17420, 540, 3714, 3714, 3, 1, 86.81368255615234375, 56.904266357421875, -13.1240797042846679, 3.324366092681884765, 7200, 0, 0, 48966),
(@CGUID+5, 16700, 540, 3714, 3714, 3, 0, 55.643723, 2.632497, -13.2085495, 3.1915, 7200, 0, 0, 46924),
-- Entrance Hall
(@CGUID+6 , 16507, 540, 3714, 3714, 3, 0, 66.4761, 41.3677, -13.1385, 4.69494, 7200, 0, 0, 46924),
(@CGUID+7 , 16507, 540, 3714, 3714, 3, 0, 73.1236, 41.2079, -13.1385, 4.62512, 7200, 0, 0, 46924),
(@CGUID+8 , 16507, 540, 3714, 3714, 3, 0, 65.2527, 97.5125, -13.1385, 4.69494, 7200, 0, 0, 46924),
(@CGUID+9 , 16507, 540, 3714, 3714, 3, 0, 73.9969, 96.7719, -13.1385, 4.53786, 7200, 0, 0, 46924),
(@CGUID+10, 16700, 540, 3714, 3714, 3, 0, 57.7881, 73.722, -13.1444, 0.753955, 7200, 0, 0, 46924),
(@CGUID+11, 16594, 540, 3714, 3714, 3, 0, 54.4005, 77.7188, -13.1092, 5.55015, 7200, 0, 0, 46924),
(@CGUID+12, 17420, 540, 3714, 3714, 3, 0, 56.461, 79.2481, -13.0995, 5.46288, 7200, 0, 0, 46924),
(@CGUID+13, 16523, 540, 3714, 3714, 3, 0, 63.3135, 84.0945, -13.1156, 4.66003, 7200, 0, 0, 46924),
(@CGUID+14, 16594, 540, 3714, 3714, 3, 0, 65.4234, 84.6101, -13.1184, 4.60767, 7200, 0, 0, 46924),
(@CGUID+15, 16594, 540, 3714, 3714, 3, 0, 75.3346, 83.7984, -13.1169, 4.13643, 7200, 0, 0, 46924),
(@CGUID+16, 17420, 540, 3714, 3714, 3, 0, 77.3988, 82.8904, -13.1101, 3.9619, 7200, 0, 0, 46924),
(@CGUID+17, 17694, 540, 3714, 3714, 3, 0, 82.4351, 76.1707, -13.1121, 3.735, 7200, 0, 0, 46924),
(@CGUID+18, 17420, 540, 3714, 3714, 3, 0, 84.0513, 74.3693, -13.1203, 3.71755, 7200, 0, 0, 46924);

DELETE FROM `creature_addon` WHERE (`guid` BETWEEN @CGUID AND @CGUID+18);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 0, 0, 0, NULL),
(@CGUID+1, 0, 0, 0, 0, 0, 0, NULL),
(@CGUID+2, 0, 0, 0, 0, 0, 0, NULL),
(@CGUID+3, 0, 0, 0, 0, 0, 0, NULL),
(@CGUID+4, 0, 0, 0, 0, 0, 0, NULL),
(@CGUID+6, 0, 0, 0, 1, 333, 0, '18950'),
(@CGUID+7, 0, 0, 0, 1, 333, 0, '18950'),
(@CGUID+8, 0, 0, 0, 1, 333, 0, '18950'),
(@CGUID+9, 0, 0, 0, 1, 333, 0, '18950');

DELETE FROM `creature_text` WHERE `CreatureID` = 16700;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16700, 0, 0, '%s goes into a rage after seeing a friend fall in battle!', 16, 0, 100, 0, 0, 0, 1151, 0, 'Shattered Hand Legionnaire'),

(16700, 1, 0, 'For Kargath!  For Victory!', 12, 0, 100, 0, 0, 0, 16698, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 1, 'Gakarah ma!', 12, 0, 100, 0, 0, 0, 16699, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 2, 'Lok narash!', 12, 0, 100, 0, 0, 0, 16703, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 3, 'Lok\'tar Illadari!', 12, 0, 100, 0, 0, 0, 16701, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 4, 'The blood is our power!', 12, 0, 100, 0, 0, 0, 16700, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 5, 'This world is OURS!', 12, 0, 100, 0, 0, 0, 16702, 0, 'Shattered Hand Legionnaire'),
(16700, 1, 6, 'We are the true Horde!', 12, 0, 100, 0, 0, 0, 16697, 0, 'Shattered Hand Legionnaire'),

(16700, 2, 0, 'Line up and crush these fools!', 14, 0, 100, 15, 0, 10187, 16346, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 1, 'Form up! Let\'s make quick work of them!', 14, 0, 100, 15, 0, 10188, 16347, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 2, 'Get ready! This shouldn\'t take long...', 14, 0, 100, 15, 0, 10189, 16349, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 3, 'Form ranks and make the intruders pay!', 14, 0, 100, 15, 0, 10190, 17461, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 4, 'Show them no quarter! Form up!', 14, 0, 100, 15, 0, 10191, 16350, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 5, 'Lok-Narash! Defensive positions!', 14, 0, 100, 15, 0, 10192, 16352, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 6, 'Hold the line! They must not get through!', 14, 0, 100, 15, 0, 10193, 16353, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 7, 'Gakarah ma!', 14, 0, 100, 15, 0, 10194, 16354, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 8, 'Hold them back at all costs!', 14, 0, 100, 15, 0, 10195, 17462, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 2, 9, 'We must halt their advance! Take your positions!', 14, 0, 100, 15, 0, 10196, 16355, 0, 'Shattered Hand Legionnaire - Variation 1'),

(16700, 3, 0, 'Fighter down!', 14, 0, 100, 0, 0, 10172, 16356, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 1, 'Replacement, quickly!', 14, 0, 100, 0, 0, 10173, 16357, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 2, 'Next warrior, now!', 14, 0, 100, 0, 0, 10174, 16358, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 3, 'Fall in! Mok-thora ka!', 14, 0, 100, 0, 0, 10175, 16359, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 4, 'Where\'s my support?', 14, 0, 100, 0, 0, 10176, 16360, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 5, 'Look Alive!', 14, 0, 100, 0, 0, 10177, 0, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 6, 'Engage the enemy!', 14, 0, 100, 0, 0, 10178, 0, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 7, 'Attack!', 14, 0, 100, 0, 0, 10179, 0, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 8, 'Next warrior, step up!', 14, 0, 100, 0, 0, 10180, 16361, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 3, 9, 'Join the fight! Agrama-ka!', 14, 0, 100, 0, 0, 10181, 16362, 0, 'Shattered Hand Legionnaire - Variation 1'),

(16700, 4, 0, 'Wake up, we\'re under attack!', 14, 0, 100, 0, 0, 10182, 16363, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 4, 1, 'Sleep on your own time!', 14, 0, 100, 0, 0, 10183, 16364, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 4, 2, 'Get up!', 14, 0, 100, 0, 0, 10184, 16365, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 4, 3, 'On your feet!', 14, 0, 100, 0, 0, 10185, 16366, 0, 'Shattered Hand Legionnaire - Variation 1'),
(16700, 4, 4, 'No time for slumber! Join the fight!', 14, 0, 100, 0, 0, 10186, 16367, 0, 'Shattered Hand Legionnaire - Variation 1'),

(16700, 5, 0, 'Line up and crush these fools!', 14, 0, 100, 15, 0, 10212, 16346, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 1, 'Form up! Let\'s make quick work of them!', 14, 0, 100, 15, 0, 10213, 16347, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 2, 'Get ready! This shouldn\'t take long...', 14, 0, 100, 15, 0, 10214, 16349, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 3, 'Form ranks and make the intruders pay!', 14, 0, 100, 15, 0, 10215, 17461, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 4, 'Show them no quarter! Form up!', 14, 0, 100, 15, 0, 10216, 16350, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 5, 'Lok-Narash! Defensive positions!', 14, 0, 100, 15, 0, 10217, 16352, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 6, 'Hold the line! They must not get through!', 14, 0, 100, 15, 0, 10218, 16353, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 7, 'Gakarah ma!', 14, 0, 100, 15, 0, 10219, 16354, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 8, 'Hold them back at all costs!', 14, 0, 100, 15, 0, 10220, 17462, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 5, 9, 'We must halt their advance! Take your positions!', 14, 0, 100, 15, 0, 10221, 16355, 0, 'Shattered Hand Legionnaire - Variation 2'),

(16700, 6, 0, 'Fighter down!', 14, 0, 100, 0, 0, 10197, 16356, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 1, 'Replacement, quickly!', 14, 0, 100, 0, 0, 10198, 16357, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 2, 'Next warrior, now!', 14, 0, 100, 0, 0, 10199, 16358, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 3, 'Fall in! Mok-thora ka!', 14, 0, 100, 0, 0, 10200, 16359, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 4, 'Where\'s my support?', 14, 0, 100, 0, 0, 10201, 16360, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 5, 'Look Alive!', 14, 0, 100, 0, 0, 10202, 0, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 6, 'Engage the enemy!', 14, 0, 100, 0, 0, 10203, 0, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 7, 'Attack!', 14, 0, 100, 0, 0, 10204, 0, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 8, 'Next warrior, step up!', 14, 0, 100, 0, 0, 10205, 16361, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 6, 9, 'Join the fight! Agrama-ka!', 14, 0, 100, 0, 0, 10206, 16362, 0, 'Shattered Hand Legionnaire - Variation 2'),

(16700, 7, 0, 'Wake up, we\'re under attack!', 14, 0, 100, 0, 0, 10207, 16363, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 7, 1, 'Sleep on your own time!', 14, 0, 100, 0, 0, 10208, 16364, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 7, 2, 'Get up!', 14, 0, 100, 0, 0, 10209, 16365, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 7, 3, 'On your feet!', 14, 0, 100, 0, 0, 10210, 16366, 0, 'Shattered Hand Legionnaire - Variation 2'),
(16700, 7, 4, 'No time for slumber! Join the fight!', 14, 0, 100, 0, 0, 10211, 16367, 0, 'Shattered Hand Legionnaire - Variation 2'),

(16700, 8, 0, 'Line up and crush these fools!', 14, 0, 100, 15, 0, 10237, 16346, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 1, 'Form up! Let\'s make quick work of them!', 14, 0, 100, 15, 0, 10238, 16347, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 2, 'Get ready! This shouldn\'t take long...', 14, 0, 100, 15, 0, 10239, 16349, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 3, 'Form ranks and make the intruders pay!', 14, 0, 100, 15, 0, 10240, 17461, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 4, 'Show them no quarter! Form up!', 14, 0, 100, 15, 0, 10241, 16350, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 5, 'Lok-Narash! Defensive positions!', 14, 0, 100, 15, 0, 10242, 16352, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 6, 'Hold the line! They must not get through!', 14, 0, 100, 15, 0, 10243, 16353, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 7, 'Gakarah ma!', 14, 0, 100, 15, 0, 10244, 16354, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 8, 'Hold them back at all costs!', 14, 0, 100, 15, 0, 10245, 17462, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 8, 9, 'We must halt their advance! Take your positions!', 14, 0, 100, 15, 0, 10246, 16355, 0, 'Shattered Hand Legionnaire - Variation 3'),

(16700, 9, 0, 'Fighter down!', 14, 0, 100, 0, 0, 10222, 16356, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 1, 'Replacement, quickly!', 14, 0, 100, 0, 0, 10223, 16357, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 2, 'Next warrior, now!', 14, 0, 100, 0, 0, 10224, 16358, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 3, 'Fall in! Mok-thora ka!', 14, 0, 100, 0, 0, 10225, 16359, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 4, 'Where\'s my support?', 14, 0, 100, 0, 0, 10226, 16360, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 5, 'Look Alive!', 14, 0, 100, 0, 0, 10227, 0, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 6, 'Engage the enemy!', 14, 0, 100, 0, 0, 10228, 0, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 7, 'Attack!', 14, 0, 100, 0, 0, 10229, 0, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 8, 'Next warrior, step up!', 14, 0, 100, 0, 0, 10230, 16361, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 9, 9, 'Join the fight! Agrama-ka!', 14, 0, 100, 0, 0, 10231, 16362, 0, 'Shattered Hand Legionnaire - Variation 3'),

(16700, 10, 0, 'Wake up, we\'re under attack!', 14, 0, 100, 0, 0, 10232, 16363, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 10, 1, 'Sleep on your own time!', 14, 0, 100, 0, 0, 10233, 16364, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 10, 2, 'Get up!', 14, 0, 100, 0, 0, 10234, 16365, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 10, 3, 'On your feet!', 14, 0, 100, 0, 0, 10235, 16366, 0, 'Shattered Hand Legionnaire - Variation 3'),
(16700, 10, 4, 'No time for slumber! Join the fight!', 14, 0, 100, 0, 0, 10236, 16367, 0, 'Shattered Hand Legionnaire - Variation 3'),

(16700, 11, 0, 'We\'ll drink their blood and feast on their bones!', 12, 0, 100, 15, 0, 0, 12683, 0, 'Shattered Hand Legionnaire'), -- Causes Cheer
(16700, 12, 0, 'Serve the Fel Horde!', 12, 0, 100, 5, 0, 0, 12684, 0, 'Shattered Hand Legionnaire'), -- Causes Bow
(16700, 13, 0, 'Power to the Fel Horde!', 12, 0, 100, 5, 0, 0, 12685, 0, 'Shattered Hand Legionnaire'),
(16700, 13, 1, 'Break their bones!', 12, 0, 100, 5, 0, 0, 12686, 0, 'Shattered Hand Legionnaire'),
(16700, 14, 0, 'Know your master, you worthless mutts!', 12, 0, 100, 25, 0, 0, 12687, 0, 'Shattered Hand Legionnaire'); -- Causes Kneel

DELETE FROM `waypoints` WHERE `entry` IN (1742000, 1742001, 1742002, 1742003, 1742004, 1670000, 1670001);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- @CGUID+0
(1742000,1,67.89315 ,39.01408,-13.229578,NULL,'Shattered Halls Entrance Path 1'),
(1742000,2,64.01922,12.312322,-13.218981,NULL,'Shattered Halls Entrance Path 1'),
(1742000,3,46.6975,4.630538,-13.19063,NULL,'Shattered Halls Entrance Path 1'),
(1742000,4,33.76568,6.794648,-13.194232,NULL,'Shattered Halls Entrance Path 1'),
(1742000,5,22.778257,7.142359,-13.188942,NULL,'Shattered Halls Entrance Path 1'),
-- @CGUID+1
(1742001,1,69.60132 ,39.09185,-13.229795,NULL,'Shattered Halls Entrance Path 2'),
(1742001,2,65.8643,14.480076,-13.217177,NULL,'Shattered Halls Entrance Path 2'),
(1742001,3,57.274395,7.420197,-13.215047,NULL,'Shattered Halls Entrance Path 2'),
(1742001,4,45.698727,6.426157,-13.190653,NULL,'Shattered Halls Entrance Path 2'),
-- @CGUID+2
(1742002,1,70.861275 ,33.167652,-13.21322,NULL,'Shattered Halls Entrance Path 3'),
(1742002,2,63.098648,2.3879812,-13.195556,NULL,'Shattered Halls Entrance Path 3'),
(1742002,3,36.641575,-1.554714,-13.195765,NULL,'Shattered Halls Entrance Path 3'),
(1742002,4,25.258875,-4.476578,-13.188146,NULL,'Shattered Halls Entrance Path 3'),
(1742002,5,12.378354,-2.327011,-13.191283,NULL,'Shattered Halls Entrance Path 3'),
-- @CGUID+3
(1742003,1,73.65649 ,52.423386,-13.222654,NULL,'Shattered Halls Entrance Path 4'),
(1742003,2,71.590904,37.800205,-13.226182,NULL,'Shattered Halls Entrance Path 4'),
(1742003,3,70.05679,10.57433,-13.220902,NULL,'Shattered Halls Entrance Path 4'),
(1742003,4,52.602608,-0.81406,-13.202705,NULL,'Shattered Halls Entrance Path 4'),
(1742003,5,37.00712,-1.507957,-13.195853,NULL,'Shattered Halls Entrance Path 4'),
-- @CGUID+4
(1742004,1,73.461945 ,54.436386,-13.22266,NULL,'Shattered Halls Entrance Path 5'),
(1742004,2,70.86118,26.330286,-13.190962,NULL,'Shattered Halls Entrance Path 5'),
(1742004,3,69.04973,8.987739,-13.207696,NULL,'Shattered Halls Entrance Path 5'),
(1742004,4,62.98464,-0.321715,-13.1952095,NULL,'Shattered Halls Entrance Path 5'),
(1742004,5,57.8027,-0.197392,-13.206662,NULL,'Shattered Halls Entrance Path 5'),
-- @CGUID+5
(1670000,1,55.643723,2.632497,-13.2085495,NULL,'Shattered Halls Entrance Legionnaire Path'),
(1670000,2,37.240017,1.647679,-13.19561,NULL,'Shattered Halls Entrance Legionnaire Path'),
(1670000,3,21.548931,1.672251,-13.188562,NULL,'Shattered Halls Entrance Legionnaire Path'),
(1670000,4,9.574065,1.843434,-13.191583,NULL,'Shattered Halls Entrance Legionnaire Path'),
(1670000,5,21.548931,1.672251,-13.188562,NULL,'Shattered Halls Entrance Legionnaire Path'),
(1670000,6,37.240017,1.647679,-13.19561,NULL,'Shattered Halls Entrance Legionnaire Path'),
-- @CGUID+10
(1670001,1,56.966682,74.25795,-13.222891,NULL,'Shattered Halls Entrance Legionnaire Path 2'),
(1670001,2,64.00517,79.559944,-13.22254,NULL,'Shattered Halls Entrance Legionnaire Path 2'),
(1670001,3,73.133644,78.94907,-13.222672,NULL,'Shattered Halls Entrance Legionnaire Path 2'),
(1670001,4,80.202415,73.17268,-13.22248,NULL,'Shattered Halls Entrance Legionnaire Path 2'),
(1670001,5,73.133644,78.94907,-13.222672,NULL,'Shattered Halls Entrance Legionnaire Path 2'),
(1670001,6,64.00517,79.559944,-13.22254,NULL,'Shattered Halls Entrance Legionnaire Path 2');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+0),-(@CGUID+1),-(@CGUID+2),-(@CGUID+3),-(@CGUID+4),-(@CGUID+5),-(@CGUID+10)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+0), 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(-(@CGUID+0), 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(-(@CGUID+0), 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(-(@CGUID+0), 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(-(@CGUID+0), 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1'),
(-(@CGUID+0), 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Shattered Hand Legionnaire'),
(-(@CGUID+0), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1742000, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Start Waypoint'),
(-(@CGUID+0), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Waypoint Finished - Run Script'),
(-(@CGUID+0), 0, 1003, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1670003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 1 1 - Run Script'),
(-(@CGUID+1), 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(-(@CGUID+1), 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(-(@CGUID+1), 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(-(@CGUID+1), 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(-(@CGUID+1), 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1'),
(-(@CGUID+1), 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Shattered Hand Legionnaire'),
(-(@CGUID+1), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1742001, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Start Waypoint'),
(-(@CGUID+1), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Waypoint Finished - Run Script'),
(-(@CGUID+1), 0, 1003, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1670003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 1 1 - Run Script'),
(-(@CGUID+2), 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(-(@CGUID+2), 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(-(@CGUID+2), 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(-(@CGUID+2), 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(-(@CGUID+2), 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1'),
(-(@CGUID+2), 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Shattered Hand Legionnaire'),
(-(@CGUID+2), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1742002, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Start Waypoint'),
(-(@CGUID+2), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Waypoint Finished - Run Script'),
(-(@CGUID+2), 0, 1003, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1670003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 1 1 - Run Script'),
(-(@CGUID+3), 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(-(@CGUID+3), 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(-(@CGUID+3), 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(-(@CGUID+3), 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(-(@CGUID+3), 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1'),
(-(@CGUID+3), 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Shattered Hand Legionnaire'),
(-(@CGUID+3), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1742003, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Start Waypoint'),
(-(@CGUID+3), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Waypoint Finished - Run Script'),
(-(@CGUID+3), 0, 1003, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1670003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 1 1 - Run Script'),
(-(@CGUID+4), 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(-(@CGUID+4), 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(-(@CGUID+4), 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(-(@CGUID+4), 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(-(@CGUID+4), 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1'),
(-(@CGUID+4), 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Shattered Hand Legionnaire'),
(-(@CGUID+4), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1742004, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Start Waypoint'),
(-(@CGUID+4), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1742000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Waypoint Finished - Run Script'),
(-(@CGUID+4), 0, 1003, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1670003, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 1 1 - Run Script'),
(-(@CGUID+5), 0, 0, 0, 0, 0, 100, 0, 1500, 5000, 240000, 240000, 0, 11, 30472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - In Combat - Cast \'Aura of Discipline\''),
(-(@CGUID+5), 0, 1, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Victim Casting - Cast \'Pummel\''),
(-(@CGUID+5), 0, 2, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Aggro - Say Line 1'),
(-(@CGUID+5), 0, 3, 4, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 11, 30485, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 (Friendly Dies Nearby) - Cast \'Enrage\''),
(-(@CGUID+5), 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Say Line 0'),
(-(@CGUID+5), 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1670000, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reset - Start Waypoint'),
(-(@CGUID+5), 0, 1002, 0, 40, 0, 15, 0, 0, 1670000, 0, 0, 0, 87, 1670000, 1670001, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Any Point Reached - Run Random Script'),
(-(@CGUID+5), 0, 1003, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 80, 1670002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reached Point 1 - Run Script'),
(-(@CGUID+5), 0, 1004, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Evade - Reset All Scripts'),
-- Entrance Hall Legionnaire
(-(@CGUID+10), 0, 0, 0, 0, 0, 100, 0, 1500, 5000, 240000, 240000, 0, 11, 30472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - In Combat - Cast \'Aura of Discipline\''),
(-(@CGUID+10), 0, 1, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Victim Casting - Cast \'Pummel\''),
(-(@CGUID+10), 0, 2, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Aggro - Say Line 1'),
(-(@CGUID+10), 0, 3, 4, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 11, 30485, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 (Friendly Dies Nearby) - Cast \'Enrage\''),
(-(@CGUID+10), 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Say Line 0'),
(-(@CGUID+10), 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1670001, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reset - Start Waypoint'),
(-(@CGUID+10), 0, 1002, 0, 40, 0, 33, 0, 0, 1670001, 0, 0, 0, 88, 1670004, 1670006, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Any Point Reached - Run Random Script'),
(-(@CGUID+10), 0, 1003, 0, 34, 0, 100, 0, 8, 3, 0, 0, 0, 87, 1670007, 1670008, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reached Group - Run Random Script'),
(-(@CGUID+10), 0, 1004, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Evade - Reset All Scripts');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1742000, 1670000, 1670001, 1670002, 1670003, 1670004, 1670005, 1670006, 1670007, 1670008, 1670009, 1670010));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1742000, 9, 0, 0, 0, 0, 100, 0, 600, 600, 0, 0, 0, 4, 1341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Actionlist - Play Sound 1341'),
(1742000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Actionlist - Set Emote State 333'),
(1742000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Actionlist - Set Sheath Melee'),
(1670000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 2 (Variation 1)'),
(1670000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 36, 0, 0, 0, 0, 0, 9, 17420, 0, 60, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Play Emote 36 (OneShotAttack1H)'),
(1670001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 8500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Pause Waypoint'),
(1670001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 17420, 10, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Store Target Closest Ally'),
(1670001, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Move To Stored Target'),
(1670002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Orientation to Stored Target'),
(1670002, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Start Actionlist on Stored Target'),
(1670002, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 5, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Play Emote 113 (OneShotSaluteNoSheath)'),
(1670002, 9, 3, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Play Emote 5 (OneShotExclamation)'),
(1670003, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 16700, 10, 0, 0, 0, 0, 0, 0, 'Shattered Hand Trash - Actionlist - Set Orientation Closest Creature \'Shattered Hand Legionnaire\''),
(1670003, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Trash - Actionlist - Play Emote 66 (OneShotSalute)'),
(1670003, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Trash - Actionlist - Play Emote 1 (OneShotTalk)'),
(1670003, 9, 3, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.071779489517212, 'Shattered Hand Trash - Actionlist - Set Orientation 3.071779489517212'),
(1670004, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 9, 0, 0, 40, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Data 2 1 - Perform Emote'),
(1670004, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 11'),
(1670005, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 0, 0, 40, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Data 2 2 - Perform Emote'),
(1670005, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 12'),
(1670006, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Pause Waypoint'),
(1670006, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 3, 0, 0, 1, 0, 0, 11, 0, 10, 1, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Move To Closest Creature'),
(1670007, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 0, 7, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Orientation Closest Creature'),
(1670007, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 3, 0, 0, 0, 0, 9, 0, 0, 6, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Data 2 3'), -- Set Orientation and Emote 66
(1670007, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 13'),
(1670007, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Resume Waypoint'),
(1670008, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 0, 7, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Orientation Closest Creature'),
(1670008, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 4, 0, 0, 0, 0, 9, 0, 0, 6, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Data 2 4'),
(1670008, 9, 2, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 14'), -- StandState 8
(1670008, 9, 3, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Play Emote 11'),
(1670008, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Resume Waypoint'),
(1670009, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 16700, 10, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Orientation Closest Creature \'Shattered Hand Legionnaire\''),
(1670009, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Remove FlagStandstate Kneel'),
(1670009, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Play Emote 66'),
(1670010, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 16700, 10, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Orientation Closest Creature \'Shattered Hand Legionnaire\''),
(1670010, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Remove FlagStandstate Kneel'),
(1670010, 9, 2, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Set Flag Standstate Kneel');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = -151005);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1003, -151005, 0, 0, 29, 1, 17420, 10, 0, 0, 0, 0, '', 'Shattered Halls Entrance event requires another NPC nearby');

/*
	Re-Do Base SAI
	Heathen, Savage, Acolyte, Darkcaster, Reaver, Brawler
*/
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17420) AND (`source_type` = 0) AND (`id` BETWEEN 5 AND 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17420, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 40, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Just Died - Set Data 1 1 on Closest Legionnaire'),
(17420, 0, 6, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(17420, 0, 7, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(17420, 0, 8, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 2 3 - Run Script'),
(17420, 0, 9, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16523) AND (`source_type` = 0) AND (`id` BETWEEN 5 AND 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16523, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Just Died - Set Data 1 1 on Closest Legionnaire'),
(16523, 0, 6, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(16523, 0, 7, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(16523, 0, 8, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Data Set 2 3 - Run Script'),
(16523, 0, 9, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16594) AND (`source_type` = 0) AND (`id` BETWEEN 11 AND 15);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16594, 0, 11, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shadowmoon Acolyte - On Death - Set Data 1 1 on Closest Legionnaire'),
(16594, 0, 12, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Acolyte - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(16594, 0, 13, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Acolyte - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(16594, 0, 14, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Acolyte - On Data Set 2 3 - Run Script'),
(16594, 0, 15, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Acolyte - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17694) AND (`source_type` = 0) AND (`id` BETWEEN 7 AND 11);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17694, 0, 7, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Death - Set Data 1 1 on Closest Legionnaire'),
(17694, 0, 8 , 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(17694, 0, 9 , 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(17694, 0, 10, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 2 3 - Run Script'),
(17694, 0, 11, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16699) AND (`source_type` = 0) AND (`id` BETWEEN 5 AND 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16699, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Just Died - Set Data 1 1 on Closest Legionnaire'),
(16699, 0, 6, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(16699, 0, 7, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(16699, 0, 8, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 2 3 - Run Script'),
(16699, 0, 9, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16593) AND (`source_type` = 0) AND (`id` BETWEEN 2 AND 7);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16593, 0, 2, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Aggro - Say Line 1'),
(16593, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16700, 20, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Just Died - Set Data 1 1 on Closest Legionnaire'),
(16593, 0, 4, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Data Set 2 1 - Play Emote 71 (OneShotCheerNoSheathe)'),
(16593, 0, 5, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Data Set 2 2 - Play Emote 2 (OneShotBow)'),
(16593, 0, 6, 0, 38, 0, 100, 0, 2, 3, 0, 0, 0, 80, 1670009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Data Set 2 3 - Run Script'),
(16593, 0, 7, 0, 38, 0, 100, 0, 2, 4, 0, 0, 0, 80, 1670010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Data Set 2 4 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16700, 0, 0, 0, 0, 0, 100, 0, 1500, 5000, 240000, 240000, 0, 11, 30472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - In Combat - Cast \'Aura of Discipline\''),
(16700, 0, 1, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Victim Casting - Cast \'Pummel\''),
(16700, 0, 2, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Aggro - Say Line 1'),
(16700, 0, 3, 4, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 11, 30485, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 (Friendly Dies Nearby) - Cast \'Enrage\''),
(16700, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Say Line 0');
