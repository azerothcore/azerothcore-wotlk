-- DB update 2023_05_28_01 -> 2023_05_28_02
-- Change from old value to new value
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~67108864|134217728 WHERE `entry` IN (16507,16523,16593,16594,16699,16700,16704,17420,17462,17464,17653,17694,17722,17800,17803,17993,17994,18155,18404,18405,18420,18421,18422,18620,18631,18632,18633,18634,18635,18639,18640,18641,18829,19166,19168,19505,19510,19735,19767,20059,20576,20577,20582,20586,20587,20589,20590,20591,20593,20594,20595,20621,20622,20625,20638,20640,20641,20642,20643,20647,20648,20649,20864,20865,20867,20868,20873,20875,20881,20883,20988,20990,21522,21523,21539,21540,21541,21542,21543,21544,21545,21548,21549,21570,21571,21574,21577,21578,21591,21593,21604,21605,21607,21608,21615,21619);
-- Add new flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|67108864 WHERE `entry` IN (17462, 20595, 14834);

-- Misc Fix for ShH
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17462) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17462, 0, 2, 0, 40, 0, 100, 0, 4, 1746200, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Ended - Set In Combat With Zone');
