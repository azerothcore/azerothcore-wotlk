-- DB update 2026_03_07_02 -> 2026_03_07_03
UPDATE `spell_proc` SET `SpellFamilyMask0` = 4096, `ProcFlags` = 0, `Charges` = 0 WHERE `SpellId` = 36032;
UPDATE `spell_proc` SET `SpellFamilyMask0` = 0, `AttributesMask` = 8 WHERE `SpellId` = 44401;
