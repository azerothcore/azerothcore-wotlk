-- DB update 2026_02_25_03 -> 2026_02_25_04
-- Fix Killing Machine PPM values for ranks 3-5
-- Previous values (1, 2, 4, 6, 8) used non-linear scaling
-- Correct values (1, 2, 3, 4, 5) use linear scaling matching tooltip
-- Formula: attackSpeed * talentRank / 60, yielding talentRank PPM

UPDATE `spell_proc` SET `ProcsPerMinute` = 3 WHERE `SpellId` = 51128; -- Killing Machine Rank 3
UPDATE `spell_proc` SET `ProcsPerMinute` = 4 WHERE `SpellId` = 51129; -- Killing Machine Rank 4
UPDATE `spell_proc` SET `ProcsPerMinute` = 5 WHERE `SpellId` = 51130; -- Killing Machine Rank 5
