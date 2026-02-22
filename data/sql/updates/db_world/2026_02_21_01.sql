-- DB update 2026_02_21_00 -> 2026_02_21_01
-- Omen of Clarity: revert SpellTypeMask to 0 to match TrinityCore
UPDATE `spell_proc` SET `SpellTypeMask` = 0 WHERE `SpellId` = 16864;
