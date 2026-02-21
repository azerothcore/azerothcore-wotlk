-- Omen of Clarity: revert SpellTypeMask to 0 to match TrinityCore
UPDATE `spell_proc` SET `SpellTypeMask` = 0 WHERE `SpellId` = 16864;
