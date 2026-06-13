-- DB update 2025_12_12_01 -> 2025_12_12_02
-- Blacksmith Goodman emote state 173 plays hammering motion
UPDATE `creature` SET `position_x` = 2938.843, `position_y` = -333.74777, `position_z` = 114.74067, `orientation` = 0.645771801471710205, `VerifiedBuild` = 64481 WHERE `guid` = 104699 AND `id1` = 27234;
UPDATE `creature_addon` SET `emote` = 173 WHERE `guid` = 104699;
