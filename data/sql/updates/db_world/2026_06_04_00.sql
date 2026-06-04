-- DB update 2026_06_02_03 -> 2026_06_04_00
-- Mage Clearcasting: allow Blizzard periodic damage ticks to trigger Arcane Concentration.
UPDATE `spell_proc` SET `ProcFlags` = 0x00050000, `SpellPhaseMask` = 0x3, `AttributesMask` = 0x8 WHERE `SpellId` = 12536;
