-- DB update 2026_11_09_03 -> 2026_11_10_00
-- Combustion (11129): drop Molten Armor damage (SpellFamilyFlags[1] 0x8) from the proc mask
UPDATE `spell_proc` SET `SpellFamilyMask1` = `SpellFamilyMask1` & ~0x8 WHERE `SpellId` = 11129;
