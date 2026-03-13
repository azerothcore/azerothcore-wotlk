-- DB update 2026_02_26_03 -> 2026_02_26_04
-- Darkmoon Card: Blue Dragon - add NONE DmgClass proc flags and fix phase to CAST
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 23688;
