--
-- Restore Warrior family masks from the legacy spell_proc_event entries after the spell_proc migration.
-- Includes Hamstring (0x0002), Rend (0x0020), and Sunder Armor (0x4000).
UPDATE `spell_proc` SET `SpellFamilyName` = 4, `SpellFamilyMask0` = 0xAA604466, `SpellFamilyMask1` = 0x00400105, `SpellFamilyMask2` = 0 WHERE `SpellId` IN (-12281, -29723);
