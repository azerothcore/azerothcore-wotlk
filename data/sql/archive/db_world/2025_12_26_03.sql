-- DB update 2025_12_26_02 -> 2025_12_26_03
-- Double-Triple Checked with sniffs
DELETE FROM `creature` WHERE `guid` IN (127961, 127962) AND `id1` = 15977 AND `map` = 533;
