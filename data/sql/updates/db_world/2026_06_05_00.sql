-- DB update 2026_06_02_03 -> 2026_06_05_00

-- Restore Warrior proc spell-family masks lost during the spell_proc migration.
-- These masks include Hamstring (0x0002), Rend (0x0020), and Sunder Armor (0x4000).
UPDATE `spell_proc`
SET `SpellFamilyName` = 4,
    `SpellFamilyMask0` = 0xAA604466,
    `SpellFamilyMask1` = 0x00400105,
    `SpellFamilyMask2` = 0x00000000
WHERE `SpellId` IN (-12281, -29723);
