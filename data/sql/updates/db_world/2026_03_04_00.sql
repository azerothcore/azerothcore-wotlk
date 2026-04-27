-- DB update 2026_03_03_03 -> 2026_03_04_00
-- Fix Seal of Command (20375) not proccing from HotR and ShoR
UPDATE `spell_proc` SET `SchoolMask` = 0, `SpellFamilyName` = 10, `SpellFamilyMask1` = 0x168000 WHERE `SpellId` = 20375;
