-- Quest 486 "Ursal the Mauler" (Teldrassil): the four Enslaved Druids of the Talon
-- (entry 2852, guids 46212-46215) never reacted to Ursal's (2039) death. They should
-- wake from their forced sleep, morph into Freed Druids of the Talon (2853), and flee
-- along a short path before despawning; one of them announces the group is free.
--
-- Implemented via SmartAI: Ursal on death sets data 2/2 on the nearby druids. Following
-- the cMaNGOS reference (the more polished of the two engines), all four wake together,
-- then transform and peel off in a timed cascade rather than snapping away in unison:
-- the speaker (guid 46215) says the line at 2s and morphs at 3s, two druids follow at 4s
-- and the last at 5s. Flee path coordinates / morph target / broadcast line are identical
-- across cMaNGOS and TrinityCore. AC remaps the waypoint action/event (232 / 108) and
-- uses the `waypoints` table for the flee path.

-- Flee path shared by all freed druids.
DELETE FROM `waypoints` WHERE `entry` = 22817;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(22817, 1, 9091.11, 1857.64, 1333.71, 0, 0, 'Freed Druid of the Talon - Flee'),
(22817, 2, 9079.52, 1872.34, 1334.99, 0, 0, 'Freed Druid of the Talon - Flee'),
(22817, 3, 9024.94, 1885.46, 1334.40, 0, 0, 'Freed Druid of the Talon - Flee');

-- Enable SmartAI on the Enslaved Druid of the Talon.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2852;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (2039, -46212, -46213, -46214, -46215)) OR (`source_type` = 9 AND `entryorguid` IN (285200, 285201, 285202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2039, 0, 0, 0, 0, 0, 80, 0, 2000, 2000, 4000, 4000, 0, 0, 11, 15793, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ursal the Mauler - In Combat - Cast \'Maul\''),
(2039, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 2852, 100, 1, 0, 0, 0, 0, 0, 'Ursal the Mauler - On Just Died - Set Data 2 2 (Enslaved Druids of the Talon)'),
(-46212, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 80, 285200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Data Set 2 2 - Run Script (free + flee, 4s)'),
(-46212, 0, 1, 0, 108, 0, 100, 0, 3, 22817, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Waypoint 3 Reached - Despawn Instant'),
(-46213, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 80, 285200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Data Set 2 2 - Run Script (free + flee, 4s)'),
(-46213, 0, 1, 0, 108, 0, 100, 0, 3, 22817, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Waypoint 3 Reached - Despawn Instant'),
(-46214, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 80, 285201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Data Set 2 2 - Run Script (free + flee, 5s)'),
(-46214, 0, 1, 0, 108, 0, 100, 0, 3, 22817, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Waypoint 3 Reached - Despawn Instant'),
(-46215, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 0, 80, 285202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Data Set 2 2 - Run Script (speaker)'),
(-46215, 0, 1, 0, 108, 0, 100, 0, 3, 22817, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - On Waypoint 3 Reached - Despawn Instant (speaker)'),
(285200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Wake (Remove Standstate Sleep)'),
(285200, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 3, 2853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Morph to Freed Druid of the Talon'),
(285200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 22817, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Start Waypoint 22817'),
(285201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Wake (Remove Standstate Sleep)'),
(285201, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 3, 2853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Morph to Freed Druid of the Talon'),
(285201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 22817, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Start Waypoint 22817'),
(285202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Wake (Remove Standstate Sleep)'),
(285202, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Say Free Line'),
(285202, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 3, 2853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Morph to Freed Druid of the Talon'),
(285202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 22817, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Druid of the Talon - Script - Start Waypoint 22817');
