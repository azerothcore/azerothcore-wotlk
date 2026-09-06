-- DB update 2026_07_18_04 -> 2026_07_19_00
--
-- Valithria Dreamwalker: turn the initial Risen Archmages (37868) from persistent
-- creature spawns into summon groups on the Green Dragon Combat Trigger (38752).
-- As permanent spawns they carried the world default 7-day respawn, so they failed to
-- return on encounter reset. Ported from TrinityCore (Keader, PR #22754).
DELETE FROM `creature` WHERE `id` = 37868;
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 38752 AND `entry` = 37868;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(38752, 0, 1, 37868, 4222.86, 2504.58, 364.96, 3.90954, 8, 0, 'Risen Archmage'),
(38752, 0, 1, 37868, 4223.4, 2465.11, 364.952, 2.3911, 8, 0, 'Risen Archmage'),
(38752, 0, 2, 37868, 4230.44, 2478.56, 364.953, 2.93215, 8, 0, 'Risen Archmage'),
(38752, 0, 2, 37868, 4230.53, 2490.22, 364.957, 3.36849, 8, 0, 'Risen Archmage'),
(38752, 0, 3, 37868, 4185.29, 2464.01, 364.87, 0.798137, 8, 0, 'Risen Archmage'),
(38752, 0, 3, 37868, 4183.7, 2503.93, 364.879, 5.50843, 8, 0, 'Risen Archmage');
