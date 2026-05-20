-- Restore Warrior Sword Specialization/Sudden Death masks after spell_proc migration
UPDATE `spell_proc` SET `SpellFamilyName`=4, `SpellFamilyMask0`=0xAA604466, `SpellFamilyMask1`=0x00400105, `SpellFamilyMask2`=0x00000000, `SpellTypeMask`=0, `SpellPhaseMask`=2 WHERE `SpellId`=-12281;
UPDATE `spell_proc` SET `SpellFamilyName`=4, `SpellFamilyMask0`=0xAA604466, `SpellFamilyMask1`=0x00400105, `SpellFamilyMask2`=0x00000000, `SpellTypeMask`=0, `SpellPhaseMask`=2|4 WHERE `SpellId`=-29723;
