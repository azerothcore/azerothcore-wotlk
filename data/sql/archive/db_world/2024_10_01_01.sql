-- DB update 2024_10_01_00 -> 2024_10_01_01
--
-- visibilityDistanceType to infinite for Orgrim's Hammer and The Skybreaker marker npcs
UPDATE `creature_addon` SET `visibilityDistanceType` = 5 WHERE `guid` IN (134846, 134847);
