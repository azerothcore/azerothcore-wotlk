-- Combustion (11129): drop Molten Armor damage (SpellFamilyFlags[1] 0x8) from the proc mask
UPDATE `spell_proc` SET `SpellFamilyMask1` = `SpellFamilyMask1` & ~0x8 WHERE `SpellId` = 11129;
