-- Escort path: Daedal's spawn -> priestess (point 4, roleplay) -> back to spawn (point 7).
-- Point 4 faces the priestess (o 1.87579) so the pause does not flash him to a default
-- facing; the home facing on arrival is restored via the ESCORT_ENDED row below.
DELETE FROM `waypoints` WHERE `entry` = 17215;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(17215, 1, -4193.1, -12475.7, 45.8185, 0, 0, 'Daedal - walk to priestess'),
(17215, 2, -4195.57, -12477.3, 45.7839, 0, 0, 'Daedal - walk to priestess'),
(17215, 3, -4198.76, -12476.5, 45.7583, 0, 0, 'Daedal - walk to priestess'),
(17215, 4, -4200.59, -12472.2, 45.6273, 1.87579, 0, 'Daedal - at priestess (roleplay)'),
(17215, 5, -4196.82, -12473.2, 45.6863, 0, 0, 'Daedal - return home'),
(17215, 6, -4193.5, -12472.8, 45.634, 0, 0, 'Daedal - return home'),
(17215, 7, -4191.15, -12470, 45.6375, 3.80482, 0, 'Daedal - home');

-- Daedal (17215) event script: walk on reward, pause + run the roleplay once he reaches the
-- priestess at waypoint 4, and turn back to his spawn facing when the escort ends.
-- Rows 0/1/3/4 are unchanged from before.
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 17215;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17215, 0, 0, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Data Set 1 1 - Set NPC Flags'),
(17215, 0, 1, 0, 38, 0, 100, 512, 2, 2, 0, 0, 0, 0, 81, 83, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Data Set 2 2 - Set NPC Flags'),
(17215, 0, 2, 3, 20, 0, 100, 512, 9473, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Quest \'An Alternative Alternative\' Rewarded - Remove NPC Flags'),
(17215, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 17215, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Link - Start Waypoint (Walk)'),
(17215, 0, 4, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Just Summoned - Set Event Phase 1'),
(17215, 0, 5, 0, 1, 1, 100, 0, 3000, 3000, 5000, 8000, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Out of Combat - Play Emote 4'),
(17215, 0, 6, 7, 40, 0, 100, 0, 4, 17215, 0, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Waypoint 4 Reached - Pause Path'),
(17215, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1721500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Link - Run Script'),
(17215, 0, 8, 9, 40, 0, 100, 0, 7, 17215, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -4191.15, -12470, 45.6375, 3.80482, 'Daedal - On Waypoint 7 (home) Reached - Set Orientation (spawn facing)'),
(17215, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 83, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - On Link - Restore NPC Flags (home)');

-- Roleplay actionlist 1721500. Same dialogue/timing as before (it already wakes and re-comas
-- the priestess via Set Data, driving her own bytes-1 script); adds: an opening Set
-- Orientation so Daedal faces the priestess, his kneel (emote 16) while applying the cure,
-- and the priestess pointing in alarm (emote 25) - both present in TrinityCore and cMaNGOS.
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 1721500;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1721500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Face Injured Night Elf Priestess'),
(1721500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 1'),
(1721500, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Play Emote Kneel (apply cure)'),
(1721500, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 2'),
(1721500, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 0 (Injured Night Elf Priestess)'),
(1721500, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 1 (Injured Night Elf Priestess)'),
(1721500, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Set Data 1 1 (Injured Night Elf Priestess)'),
(1721500, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 2 (Injured Night Elf Priestess)'),
(1721500, 9, 8, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 3 (Injured Night Elf Priestess)'),
(1721500, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Priestess Play Emote Point (alarm)'),
(1721500, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 4 (Injured Night Elf Priestess)'),
(1721500, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 17117, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Set Data 2 2 (Injured Night Elf Priestess)'),
(1721500, 9, 12, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 17214, 0, 0, 0, 0, 0, 0, 0, 'Daedal - Script - Say Line 2 (Anchorite Fateema)');
