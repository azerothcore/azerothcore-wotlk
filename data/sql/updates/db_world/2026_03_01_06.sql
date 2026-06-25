-- DB update 2026_03_01_05 -> 2026_03_01_06
-- Seal of Light (20165): Fix PPM 20 -> 10
UPDATE `spell_proc` SET `ProcsPerMinute` = 10 WHERE `SpellId` = 20165;

-- Flame Cap (28714): Add 6 PPM (was 100% with no spell_proc entry)
DELETE FROM `spell_proc` WHERE `SpellId` = 28714;
INSERT INTO `spell_proc` (`SpellId`, `ProcsPerMinute`, `SpellTypeMask`, `SpellPhaseMask`) VALUES (28714, 6, 1, 2);
