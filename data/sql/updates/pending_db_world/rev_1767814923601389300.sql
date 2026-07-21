SET @GUID := 53048;

-- Leaving this Claude comment here for his explanation
-- It did the game_event scheduling

-- Event schedule.
--
-- 92 (Setup) is the ONLY clock event. World::Update fires it hourly from
-- `start_time`, it spawns the Warsong Scout, and the Scout's roleplay hands the
-- Warsong Captain the rest of the sequence. Because everything downstream chains
-- off 92, re-phasing 92 shifts the event as a unit and cannot desync it.
--
-- 93 Marksmen, 94 Sky Darkeners and 95 Boss are MANUAL: `start_time` in the future
-- puts them beyond the scheduler's reach (CheckOneGameEvent requires
-- Start < currenttime), so only SMART_ACTION_GAME_EVENT_START (112) reaches them.
-- The Captain starts all three from actionlist 2544600, which makes him the anchor
-- for the whole sequence.
--
-- `length` is the safety net, and it is enforced by World::Update rather than by
-- any creature's AI: whatever becomes of the Captain, every manual event closes
-- itself and despawns its creatures through the grid spawn data. If his grid
-- unloads mid-sequence the remaining phases simply never fire - nothing is left
-- stuck, and nobody was there to watch anyway.
--
-- TESTING: `.event start 92` runs the entire sequence. It re-anchors 92's phase
-- until the next worldserver restart, which shifts the event but cannot desync it.
-- Nothing may call SMART_ACTION_GAME_EVENT_STOP (111) on 92 for the same reason.
SET @EVENT_OCCURENCE   := 60;
SET @EVENT_ANCHOR      := '2000-01-01 00:00:00';
SET @DELAY_BOSS        := 900000; -- ms after the Captain's order before Ith'rix flies in
SET @LENGTH_SETUP      := 5;    -- Scout window
SET @LENGTH_DARKENERS  := 15;   -- static swarm window, timed from the Captain's order
SET @LENGTH_BOSS       := 20;   -- must stay under Ith'rix's 1800s spawntimesecs
SET @LENGTH_MARKSMEN   := 40;   -- failsafe only, normally ended by Ith'rix's death

DELETE FROM `creature_template_addon` WHERE (`entry` = 25439);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(25439, 0, 0, 0, 2, 0, 0, '42459');

DELETE FROM `creature_template_addon` WHERE (`entry` = 25244);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(25244, 0, 0, 0, 2, 0, 0, '');

-- Delete old Warsong Captain
DELETE FROM `creature` WHERE (`id` = 25446) AND (`guid` IN (125432));
DELETE FROM `creature_addon` WHERE `guid` IN (125432);

-- Delete stray Warsong Scout at (2861.79, 6388.8) - pollution from an uncurated
-- sniff import. Warsong Scout only ever exists as part of this event, spawned by
-- game event 92 as @GUID+2. Left in place he inherits the entry's SmartAI and, on
-- his own 300s respawn, walks path 254391 to the Warsong Captain and starts the
-- roleplay with no game event active.
DELETE FROM `creature` WHERE (`id` = 25439) AND (`guid` IN (104497));
DELETE FROM `creature_addon` WHERE `guid` IN (104497);

UPDATE `creature_template` SET `unit_flags` = 32768 WHERE (`entry` = 25439);

DELETE FROM `creature_text` WHERE (`CreatureID` = 25439);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25439, 0, 0, 'Captain... Nerub\'ar flyers! Hundreds of \'em! Coming... Coming from the south! Over our defenses!', 12, 1, 100, 5, 0, 0, 24653, 0, 'Warsong Scout - What The Cold Wind Brings... Event'),
(25439, 1, 0, 'There! There!', 12, 1, 100, 5, 0, 0, 24654, 0, 'Warsong Scout - What The Cold Wind Brings... Event');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25446);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25446, 0, 0, 'Settle down, soldier!', 12, 1, 100, 5, 0, 0, 24655, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 1, 0, 'We\'ll be ready for \'em... You did a good job in warning us.', 12, 1, 100, 1, 0, 0, 24656, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 2, 0, 'Marksmen! Front and center! Scourge attack incoming!', 14, 1, 100, 22, 0, 0, 24657, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 3, 0, 'Marksmen, lock and load!', 14, 1, 100, 22, 0, 0, 24659, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 4, 0, 'The Nerub\'ar have been punished for their transgression!', 14, 1, 100, 22, 0, 0, 24660, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 5, 0, 'Leave no survivors! Let Arthas sort \'em out...', 12, 1, 100, 0, 0, 0, 24663, 0, 'Warsong Captain'),
(25446, 5, 1, 'For Hellscream! For the Horde!', 12, 1, 100, 0, 0, 0, 24664, 0, 'Warsong Captain'),
(25446, 5, 2, 'Yes... Let the rage consume you!', 12, 1, 100, 0, 0, 0, 24665, 0, 'Warsong Captain'),
(25446, 6, 0, 'Let the forces of the Lich King gaze upon the carcass of this wretch and know that the Horde will not relent!', 14, 1, 100, 22, 0, 0, 24673, 0, 'Warsong Captain - What The Cold Wind Brings... Event'),
(25446, 7, 0, 'Gather, soldiers! Gather and take your trophies from the carapace of the enemy!', 12, 1, 100, 1, 0, 0, 24674, 0, 'Warsong Captain - What The Cold Wind Brings... Event');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25453);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25453, 0, 0, 'I will take great pleasure in tearing the forces of the Horde apart... limb from limb and piece by piece...', 14, 0, 100, 0, 0, 0, 24672, 0, 'Ith\'rix the Harvester - What The Cold Wind Brings... Event');

-- New Spawns
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+24 AND `id` IN (25446, 25453, 25439, 25244, 25451) AND `map` = 571 AND `VerifiedBuild` IN (-52237, 52237);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
-- Warsong Captain 25446
(@GUID+0, 25446, 571, 1, 1, 1, 2729.2375, 6082.6777, 73.63885, 3.368485450744628906, 120, 52237, 2, 'Part of What The Cold Wind Brings... Event'),
-- Ith'rix 25453
-- spawntimesecs must exceed event 95's length (he must not return inside his own
-- window) but expire before the next window opens at +75min, or GameEventSpawn
-- loads him dead on a pending respawn. 1800 sits in the middle of that band.
(@GUID+1, 25453, 571, 1, 1, 0, 2563.398, 6056.7534, 157.0997, 0.675718843936920166, 1800, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
-- Warsong Scout 25439 - spawned by event 92, opens the event
(@GUID+2, 25439, 571, 1, 1, 1, 2616.1462, 6083.162, 53.465275, 5.896511077880859375, 600, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
-- Warsong Marksmen 25244 - reinforce on a 5min timer for as long as event 93 runs
(@GUID+3 , 25244, 571, 1, 1, 1, 2770.6533, 6123.831, 91.788445, 3.885649919509887695, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+4 , 25244, 571, 1, 1, 1, 2772.1545, 6125.37, 91.9547, 3.918198108673095703, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+5 , 25244, 571, 1, 1, 1, 2774.0427, 6127.1343, 91.95686, 3.822271108627319335, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+6 , 25244, 571, 1, 1, 1, 2775.6, 6128.577, 91.956795, 4.136430263519287109, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+7 , 25244, 571, 1, 1, 1, 2777.2427, 6130.19, 91.95759, 0.48869219422340393, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+8 , 25244, 571, 1, 1, 1, 2780.2751, 6132.911, 91.74803, 3.298672199249267578, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+9 , 25244, 571, 1, 1, 1, 2781.4375, 6134.131, 90.92266, 0.104719758033752441, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+10, 25244, 571, 1, 1, 1, 2782.5786, 6135.2393, 90.14071, 2.617993831634521484, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+11, 25244, 571, 1, 1, 1, 2783.7375, 6136.151, 89.41592, 0.157079637050628662, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+12, 25244, 571, 1, 1, 1, 2785.7144, 6137.814, 88.14427, 5.585053443908691406, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+13, 25244, 571, 1, 1, 1, 2787.284, 6139.4194, 87.04321, 2.111848354339599609, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+14, 25244, 571, 1, 1, 1, 2788.8938, 6140.902, 85.96647, 3.893373012542724609, 300, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
-- Sky Darkeners 25451
(@GUID+15, 25451, 571, 1, 1, 0, 2586.0503, 6045.1733, 149.66963, 5.983277797698974609, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+16, 25451, 571, 1, 1, 0, 2592.336, 6055.209, 149.38055, 4.575495719909667968, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+17, 25451, 571, 1, 1, 0, 2582.3564, 6072.7163, 150.72621, 0.256311208009719848, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+18, 25451, 571, 1, 1, 0, 2586.5847, 6043.062, 150.77448, 6.154862403869628906, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+19, 25451, 571, 1, 1, 0, 2590.9182, 6052.6157, 146.73918, 2.318624496459960937, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+20, 25451, 571, 1, 1, 0, 2584.9631, 6067.6963, 148.27704, 1.537565231323242187, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+21, 25451, 571, 1, 1, 0, 2588.828, 6049.6763, 146.88951, 2.722152233123779296, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+22, 25451, 571, 1, 1, 0, 2585.2322, 6061.892, 151.63135, 0.06164625659584999, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+23, 25451, 571, 1, 1, 0, 2586.2327, 6049.5854, 150.27066, 1.737332820892333984, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event'),
(@GUID+24, 25451, 571, 1, 1, 0, 2588.501, 6063.269, 147.57248, 3.455328941345214843, 10, -52237, 2, 'Part of What The Cold Wind Brings... Event');

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @GUID AND @GUID+24 AND `eventEntry` IN (92, 93, 94, 95);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
-- 92 Setup: the Scout opens the event
(92, @GUID+2 ),
-- 93 Marksmen: the Horde response, started by the Captain, ended by Ith'rix's death
(93, @GUID+3 ),
(93, @GUID+4 ),
(93, @GUID+5 ),
(93, @GUID+6 ),
(93, @GUID+7 ),
(93, @GUID+8 ),
(93, @GUID+9 ),
(93, @GUID+10),
(93, @GUID+11),
(93, @GUID+12),
(93, @GUID+13),
(93, @GUID+14),
-- 94 Sky Darkeners: the scourge attack, on the clock, 15min static window
(94, @GUID+15),
(94, @GUID+16),
(94, @GUID+17),
(94, @GUID+18),
(94, @GUID+19),
(94, @GUID+20),
(94, @GUID+21),
(94, @GUID+22),
(94, @GUID+23),
(94, @GUID+24),
-- 95 Ith'rix
(95, @GUID+1 );

DELETE FROM `game_event` WHERE `eventEntry` IN (92, 93, 94, 95);
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `description`, `announce`) VALUES
-- The one clock event. Phase comes from `start_time`; CheckOneGameEvent is a pure
-- modulo of wall-clock time, so it is exact forever and survives restarts.
(92, @EVENT_ANCHOR, NULL, @EVENT_OCCURENCE, @LENGTH_SETUP, 'What the Cold Wind Brings... Setup', 2),
-- Manual events, same idiom as entries 97/98. `start_time` in the future means the
-- scheduler can never reach them (CheckOneGameEvent requires Start < currenttime);
-- only SMART_ACTION_GAME_EVENT_START does. Re-phasing them via GAME_EVENT_STOP is
-- therefore harmless. `length` is the bound and is enforced by World::Update, so it
-- holds even if the zone empties: 94 self-terminates 15min after the Captain's
-- order, 95 caps the boss window, and 93 covers Ith'rix never being killed.
-- `end_time` must stay NULL - a past end_time trips the Length-minutes-added-to-a-
-- seconds-timestamp bug in GameEventMgr::StopEvent.
(93, '2037-12-31 00:00:00', NULL, 5184000, @LENGTH_MARKSMEN, 'What the Cold Wind Brings... Marksmen', 0),
(94, '2037-12-31 00:00:00', NULL, 5184000, @LENGTH_DARKENERS, 'What the Cold Wind Brings... Sky Darkeners', 0),
(95, '2037-12-31 00:00:00', NULL, 5184000, @LENGTH_BOSS, 'What the Cold Wind Brings... Boss', 0);

DELETE FROM `waypoint_data` WHERE `id` = 254391;
DELETE FROM `waypoint_data` WHERE `id` IN (@GUID+1,@GUID+3,@GUID+4,@GUID+5,@GUID+6,@GUID+7,@GUID+8,@GUID+9,@GUID+10,@GUID+11,@GUID+12,@GUID+13,@GUID+14,@GUID+15,@GUID+16,@GUID+17,@GUID+18,@GUID+19,@GUID+20,@GUID+21,@GUID+22,@GUID+23,@GUID+24);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- Ith'rix
(@GUID+1, 1, 2563.398, 6056.7534, 157.0997, NULL, 1),
(@GUID+1, 2, 2575.5056, 6066.459, 184.14493, NULL, 1),
(@GUID+1, 3, 2599.5828, 6071.087, 167.20055, NULL, 1),
(@GUID+1, 4, 2635.0598, 6054.896, 146.0617, NULL, 1),
(@GUID+1, 5, 2669.789, 6057.982, 110.75616, NULL, 1),
(@GUID+1, 6, 2701.2043, 6075.8564, 84.756134, NULL, 1),
-- Scout
(254391, 1, 2644.8572, 6071.478, 53.176533, NULL, 1),
(254391, 2, 2689.8523, 6075.5894, 58.832077, NULL, 1),
(254391, 3, 2725.5837, 6081.9165, 72.0309, NULL, 1),
-- 2776.3901 6058.447 76.956604
-- Marksmen
(@GUID+3, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+3, 2, 2721.8047, 6085.8994, 71.07823, NULL, 1),
(@GUID+3, 3, 2720.7925, 6075.444, 69.52427, 4.031710624694824218, 1),

(@GUID+4, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+4, 2, 2717.3555, 6078.1665, 68.76751, NULL, 1),

(@GUID+5, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+5, 2, 2714.0583, 6081.4014, 67.76862, 3.804817676544189453, 1),

(@GUID+6, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+6, 2, 2711.0757, 6084.8125, 67.4583, 3.822271108627319335, 1),

(@GUID+7, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+7, 2, 2709.255, 6087.658, 67.6947, NULL, 1),

(@GUID+8, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+8, 2, 2708.454, 6091.862, 67.43045, 3.31612563133239746, 1),

(@GUID+9, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+9, 2, 2724.7092, 6077.167, 70.702354, NULL, 1),

(@GUID+10, 1, 2748.7588, 6103.726, 78.835945, NULL, 1),
(@GUID+10, 2, 2721.3394, 6079.3677, 70.59221, NULL, 1),

(@GUID+11, 1, 2769.6362, 6122.8945, 91.834366, NULL, 1),
(@GUID+11, 2, 2776.7327, 6129.566, 91.21277, NULL  , 1),
(@GUID+11, 3, 2762.703, 6116.529, 87.64466, NULL   , 1),
(@GUID+11, 4, 2748.7588, 6103.726, 78.835945, NULL , 1),
(@GUID+11, 5, 2718.5542, 6082.481, 69.593994, NULL , 1),

(@GUID+12, 1, 2769.6362, 6122.8945, 91.834366, NULL, 1),
(@GUID+12, 2, 2748.7588, 6103.726, 78.835945, NULL , 1),
(@GUID+12, 3, 2716.056, 6085.0522, 69.168816, 3.769911050796508789, 1),

(@GUID+13, 1, 2769.6362, 6122.8945, 91.834366, NULL, 1),
(@GUID+13, 2, 2748.7588, 6103.726, 78.835945, NULL , 1),
(@GUID+13, 3, 2714.0022, 6088.7256, 69.52429, NULL , 1),

(@GUID+14, 1, 2769.6362, 6122.8945, 91.834366, NULL, 1),
(@GUID+14, 2, 2748.7588, 6103.726, 78.835945, NULL , 1),
(@GUID+14, 3, 2712.2822, 6092.2485, 70.30503, 3.560471534729003906, 1),

-- Sky Darkeners
(@GUID+15, 1, 2586.0503, 6045.1733, 149.66963, NULL, 1),
(@GUID+15, 2, 2588.144, 6044.526, 154.98267, NULL  , 1),
(@GUID+15, 3, 2633.5933, 6041.2227, 133.03825, NULL, 1),
(@GUID+15, 4, 2668.8489, 6040.504, 109.48274, NULL , 1),
(@GUID+15, 5, 2687.2793, 6056.3604, 85.149376, NULL, 1),
(@GUID+15, 6, 2715.011, 6067.62, 78.12171, NULL    , 1),

(@GUID+16, 1, 2592.336, 6055.209, 149.38055, NULL  , 1),
(@GUID+16, 2, 2592.3293, 6055.161, 150.4271, NULL  , 1),
(@GUID+16, 3, 2618.1086, 6050.681, 138.20494, NULL , 1),
(@GUID+16, 4, 2651.2253, 6057.2124, 112.01051, NULL, 1),
(@GUID+16, 5, 2681.1536, 6068.98, 86.899376, NULL  , 1),
(@GUID+16, 6, 2699.503, 6084.1777, 78.84384, NULL  , 1),

(@GUID+17, 1, 2582.3564, 6072.7163, 150.72621, NULL, 1),
(@GUID+17, 2, 2584.909, 6073.3853, 153.62152 , NULL, 1),
(@GUID+17, 3, 2606.4019, 6078.356, 138.20494 , NULL, 1),
(@GUID+17, 4, 2648.716, 6082.432, 112.01051  , NULL, 1),
(@GUID+17, 5, 2686.0447, 6097.601, 86.899376 , NULL, 1),
(@GUID+17, 6, 2692.6892, 6100.527, 79.121635 , NULL, 1),

(@GUID+18, 1, 2586.5847, 6043.062, 150.77448, NULL, 1),
(@GUID+18, 2, 2587.3567, 6042.9624, 153.0382, NULL, 1),
(@GUID+18, 3, 2634.8323, 6034.265, 138.0105 , NULL, 1),
(@GUID+18, 4, 2668.8489, 6040.504, 111.95496, NULL, 1),
(@GUID+18, 5, 2687.2793, 6056.3604, 98.51048, NULL, 1),
(@GUID+18, 6, 2721.582, 6075.422, 83.510574 , NULL, 1),

(@GUID+19, 1, 2590.9182, 6052.6157, 146.73918, NULL, 1),
(@GUID+19, 2, 2590.6338, 6052.9224, 148.34378, NULL, 1),
(@GUID+19, 3, 2616.4456, 6042.9355, 119.73274, NULL, 1),
(@GUID+19, 4, 2646.8286, 6046.1313, 102.95495, NULL, 1),
(@GUID+19, 5, 2682.9944, 6062.8623, 86.899376, NULL, 1),
(@GUID+19, 6, 2709.3306, 6081.7173, 82.37163 , NULL, 1),

(@GUID+20, 1, 2584.9631, 6067.6963, 148.27704, NULL, 1),
(@GUID+20, 2, 2585.0112, 6069.143, 153.62152 , NULL, 1),
(@GUID+20, 3, 2610.8528, 6075.9497, 138.20494, NULL, 1),
(@GUID+20, 4, 2648.716, 6082.432, 112.01051  , NULL, 1),
(@GUID+20, 5, 2684.2646, 6091.039, 86.899376 , NULL, 1),
(@GUID+20, 6, 2700.1365, 6098.9385, 79.121635, NULL, 1),

(@GUID+21, 1, 2588.828, 6049.6763, 146.88951 , NULL, 1),
(@GUID+21, 2, 2588.7534, 6049.7095, 148.34378, NULL, 1),
(@GUID+21, 3, 2610.8147, 6042.488, 119.73274 , NULL, 1),
(@GUID+21, 4, 2641.945, 6042.146, 96.89938   , NULL, 1),
(@GUID+21, 5, 2687.2793, 6056.3604, 84.76049 , NULL, 1),
(@GUID+21, 6, 2705.8296, 6077.8105, 77.14937 , NULL, 1),

(@GUID+22, 1, 2585.2322, 6061.892, 151.63135 , NULL, 1),
(@GUID+22, 2, 2586.7668, 6061.987, 158.5104  , NULL, 1),
(@GUID+22, 3, 2622.702, 6060.414, 138.20494  , NULL, 1),
(@GUID+22, 4, 2651.4192, 6065.244, 112.01051 , NULL, 1),
(@GUID+22, 5, 2685.1294, 6079.6, 86.899376   , NULL, 1),
(@GUID+22, 6, 2703.2485, 6088.7065, 83.066086, NULL, 1),

(@GUID+23, 1, 2586.2327, 6049.5854, 150.27066, NULL, 1),
(@GUID+23, 2, 2586.1272, 6050.213, 150.78821 , NULL, 1),
(@GUID+23, 3, 2610.8147, 6042.488, 135.95494 , NULL, 1),
(@GUID+23, 4, 2641.945, 6042.146, 116.95495  , NULL, 1),
(@GUID+23, 5, 2687.2793, 6056.3604, 103.5105 , NULL, 1),
(@GUID+23, 6, 2713.4407, 6078.5156, 82.621635, NULL, 1),

(@GUID+24, 1, 2588.501, 6063.269, 147.57248  , NULL, 1),
(@GUID+24, 2, 2587.777, 6063.034, 153.62152  , NULL, 1),
(@GUID+24, 3, 2607.131, 6071.004, 138.20494  , NULL, 1),
(@GUID+24, 4, 2644.1538, 6077.7944, 112.01051, NULL, 1),
(@GUID+24, 5, 2684.2646, 6091.039, 86.899376 , NULL, 1),
(@GUID+24, 6, 2701.3816, 6093.0586, 77.62164 , NULL, 1);

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` IN (25446, 25453, 25451, 25244, 25439));

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25446;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25446);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25446, 0, 0, 1, 0, 0, 100, 0, 15000, 30000, 30000, 60000, 0, 0, 11, 45584, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - In Combat - Cast \'Bloodlust\''),
(25446, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - In Combat - Say Line 5'),
(25446, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 4000, 9000, 0, 0, 11, 12058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - In Combat - Cast \'Chain Lightning\''),
(25446, 0, 3, 0, 14, 0, 100, 0, 3000, 40, 10000, 14000, 0, 0, 11, 15799, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Friendly Hurt - Cast \'Chain Heal\''),
(25446, 0, 4, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2544600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Action Received from Warsong Scout - Run Script'),
(25446, 0, 5, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2544601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Action Received from Ith\'rix - Run Script End Event'),
(25446, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2544602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Reached Carapace - Run Gloat Script'),
-- Invincibility spans the assault: raised when the Sky Darkeners arrive, cleared
-- when the boss event ends. The 95 setter is redundant on the normal path, since 94
-- always precedes it now, but it covers a manual `.event start 95`. The respawn
-- reset below is the real safety net - SMART_EVENT_GAME_EVENT_END never reaches an
-- unloaded grid, so without it the flag could stay on if the zone empties.
(25446, 0, 7, 0, 68, 0, 100, 0, 94, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Game Event \'Sky Darkeners\' Started - Set Invincibility Hp 1'),
(25446, 0, 8, 0, 68, 0, 100, 0, 95, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Game Event \'Boss\' Started - Set Invincibility Hp 1'),
(25446, 0, 9, 0, 69, 0, 100, 0, 95, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Game Event \'Boss\' Ended - Reset Invincibility Hp'),
-- Failsafe: SMART_EVENT_GAME_EVENT_END never reaches an unloaded grid, so clear
-- invincibility on respawn too rather than leaving it stuck on.
(25446, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - On Respawn - Reset Invincibility Hp');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2544600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2544600, 9, 0 , 0, 0, 0, 100, 0, 16600, 16600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 0'),
(2544600, 9, 1 , 0, 0, 0, 100, 0, 4100, 4100, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 1'),
(2544600, 9, 2 , 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 2'),
(2544600, 9, 3 , 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 112, 93, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Start Game Event 93 (Marksmen)'),
(2544600, 9, 4 , 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 3'),
(2544600, 9, 5 , 0, 0, 0, 100, 0, 4400, 4400, 0, 0, 0, 0, 112, 94, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Start Game Event 94 (Sky Darkeners)'),
(2544600, 9, 6 , 0, 0, 0, 100, 0, @DELAY_BOSS, @DELAY_BOSS, 0, 0, 0, 0, 112, 95, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Start Game Event 95 (Ith\'rix)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2544601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Stopping 93 is safe precisely because 93 is a manual event: StopEvent(overwrite)
-- rewrites its `Start`, which would permanently re-phase a clock event. It also
-- despawns the marksmen through the grid spawn data, so it works loaded or not.
(2544601, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 111, 93, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Stop Game Event 93 (Marksmen)'),
(2544601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Set Run Off'),
(2544601, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 69, 1, 0, 0, 5, 0, 0, 20, 187674, 60, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Move To Gameobject \'Ith\'rix\'s Hardened Carapace\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2544602);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2544602, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 4'),
(2544602, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 6'),
(2544602, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Say Line 7'),
(2544602, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2729.2375, 6082.6777, 73.63885, 3.368485450744629, 'Warsong Captain - Actionlist - Move To Spawn'),
(2544602, 9, 4, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Captain - Actionlist - Set Run On');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25439;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25439);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25439, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 254391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - On Respawn - Start Path 254391'),
(25439, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(25439, 0, 2, 0, 9, 0, 100, 0, 0, 2300, 2300, 3900, 5, 30, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Within 5-30 Range - Cast \'Shoot\''),
(25439, 0, 3, 0, 2, 0, 100, 0, 0, 30, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Between 0-30% Health - Cast \'Enrage\''),
(25439, 0, 4, 0, 2, 0, 100, 0, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Between 0-15% Health - Flee For Assist'),
(25439, 0, 5, 0, 109, 0, 100, 0, 0, 254391, 0, 0, 0, 0, 80, 2543900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - On Path 254391 Finished - Run Script'),
(25439, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - On Reached Despawn Point - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2543900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2543900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 25446, 20, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Set Orientation Closest Creature \'Warsong Captain\''),
(2543900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 25446, 20, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Reached Captain, Do Action ID 1: Start Event'),
(2543900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Play Emote OneShotSalute'),
(2543900, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Say Line 0'),
(2543900, 9, 4, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.281219005584717, 'Warsong Scout - Actionlist - Set Orientation 3.281219005584717'),
(2543900, 9, 5, 0, 0, 0, 100, 0, 600, 600, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Play Emote OneShotPoint'),
(2543900, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Say Line 1'),
(2543900, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 25446, 20, 0, 0, 0, 0, 0, 0, 'Warsong Scout - Actionlist - Set Orientation Closest Creature \'Warsong Captain\''),
(2543900, 9, 8, 0, 0, 0, 100, 0, 14400, 14400, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2776.3901, 6058.447, 76.956604, 0, 'Warsong Scout - Actionlist - Move To Position');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25244;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25244);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25244, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 4000, 6000, 0, 0, 11, 38372, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - In Combat - Cast \'Shoot\''),
(25244, 0, 1, 0, 2, 0, 100, 0, 0, 30, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - Between 0-30% Health - Cast \'Enrage\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` BETWEEN -(@GUID+14) AND -(@GUID+3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@GUID+3), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+3), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+3), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+3), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+3), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+4), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+4), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+4), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+4), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+4), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+5), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+5), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+5), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+5), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+5), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+6), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+6), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+6), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+6), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+6), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+7), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+7), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+7), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+7), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+7), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+8), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+8), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+8), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+8), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+8), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+9), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+9), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+9), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+9), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+9), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+10), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+10), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+10), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+10), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+10), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+11), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+11), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+11), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+11), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+11), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+12), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+12), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+12), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+12), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+12), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+13), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+13), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+13), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+13), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+13), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script'),

(-(@GUID+14), 0, 1001, 1002, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Set Rooted Off'),
(-(@GUID+14), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+14), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Respawn - Start Path'),
(-(@GUID+14), 0, 1003, 0, 109, 0, 100, 0, 0, (@GUID+14), 0, 0, 0, 0, 80, 2524400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - On Path Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2524400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- (2524400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - Actionlist - Set Rooted On'),
(2524400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - Actionlist - Set Sheath Ranged'),
(2524400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 214, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Marksman - Actionlist - Set Emote State 214');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25451;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25451);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25451, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Just Died - Despawn In 5000 ms'),
(25451, 0, 1, 0, 0, 0, 100, 0, 9000, 13000, 17000, 23000, 0, 0, 11, 45587, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - In Combat - Cast \'Web Bolt\''),
(25451, 0, 2, 0, 0, 0, 100, 0, 0, 1500, 1500, 2000, 0, 0, 11, 45577, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - In Combat - Cast \'Venom Spit\''),
(25451, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 239, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Just Spawned - Set Fly Mode');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` BETWEEN -(@GUID+24) AND -(@GUID+15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@GUID+15), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+15), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+16), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+16), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+17), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+17), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+18), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+18), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+19), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+19), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+20), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+20), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+21), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+21), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+22), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+22), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+23), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+23), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path'),
(-(@GUID+24), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+24), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Sky Darkener - On Respawn - Start Path');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25453;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25453);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25453, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45593, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Just Died - Cast \'Ith`rix`s Carapace\''),
(25453, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 8000, 11000, 0, 0, 11, 25748, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - In Combat - Cast \'Poison Stinger\''),
(25453, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 16000, 21000, 0, 0, 11, 34392, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - In Combat - Cast \'Stinger Rage\''),
(25453, 0, 3, 0, 0, 0, 100, 0, 2000, 4000, 3000, 6000, 0, 0, 11, 45592, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - In Combat - Cast \'Venom Spit\''),
(25453, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 19, 25446, 100, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Just Died - Relay to Warsong Captain End Event'),
(25453, 0, 5, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 239, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Just Spawned - Set Fly Mode'),
(25453, 0, 6, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25446, 100, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Path Finished - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@GUID+1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@GUID+1), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Respawn - Say Line 0'),
(-(@GUID+1), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@GUID+1), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ith\'rix the Harvester - On Respawn - Start Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2545300);
