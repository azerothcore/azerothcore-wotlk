-- Issue #24701: Leotheras the Blind (153139) stays permanently banished after a wipe.
-- The formation's `groupAI = 28` includes EVADE_TOGETHER (0x4), which makes
-- CreatureGroup::MemberEvaded (CreatureGroups.cpp) take the "evade alive members" branch
-- and skip dead ones - RESPAWN_ON_EVADE (0x8) never gets a chance to fire, so the 3
-- Greyheart Spellbinders (153140/141/142) that keep Leotheras banished never come back
-- after a wipe. Dropping EVADE_TOGETHER (groupAI 28 -> 24) makes the existing
-- respawn-on-evade behavior actually run.
DELETE FROM `creature_formations` WHERE `leaderGUID` = 153139;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(153139, 153139, 0, 0, 24, 0, 0),
(153139, 153140, 0, 0, 24, 0, 0),
(153139, 153141, 0, 0, 24, 0, 0),
(153139, 153142, 0, 0, 24, 0, 0);
