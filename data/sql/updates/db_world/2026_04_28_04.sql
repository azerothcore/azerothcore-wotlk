-- DB update 2026_04_28_03 -> 2026_04_28_04
-- Adds S6 off piece vendors to creature table, and then adds them to S6 event.
DELETE FROM `creature` WHERE (`guid` IN (208509, 208510, 208511, 208512) AND `id1` IN (34036, 34058, 34073, 34076));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(208509, 34036, 0, 0, 1, 0, 0, 1, 1, 1, 1669.09, -4196.78, 56.3827, 4.10416, 25, 0, 0, 11828, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(208510, 34058, 0, 0, 1, 0, 0, 1, 1, 0, 1673.07, -4201.89, 56.3826, 3.62927, 25, 0, 0, 55888, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(208511, 34073, 0, 0, 0, 0, 0, 1, 1, 1, -8781.18, 419.883, 105.233, 6.18459, 180, 0, 0, 7048, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(208512, 34076, 0, 0, 0, 0, 0, 1, 1, 1, -8773.78, 425.804, 105.233, 4.80621, 180, 0, 0, 11828, 0, 0, 0, 0, 0, '', 0, 0, NULL);

DELETE FROM `game_event_creature` WHERE (`guid` IN (208509, 208510, 208511, 208512) AND `eventEntry` = 58);
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
(208509, 58),
(208510, 58),
(208511, 58),
(208512, 58);
