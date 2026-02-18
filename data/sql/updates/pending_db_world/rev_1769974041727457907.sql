-- Omen of Clarity should only proc from damage and healing spells, not utility spells like Furor
UPDATE `spell_proc` SET `SpellTypeMask` = 3 WHERE `SpellId` = 16864;
