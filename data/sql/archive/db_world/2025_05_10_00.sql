-- DB update 2025_05_09_01 -> 2025_05_10_00
-- Deletes `Lorgalis Manuscript` (5359) from `Aku'mai Fisher` (4824), `Blackfathom Myrmidon` (4807), `Blackfathom Sea Witch` (4805) and `Snapping Crustacean` (4822)
DELETE FROM `creature_loot_template` WHERE `Item` = 5359;
