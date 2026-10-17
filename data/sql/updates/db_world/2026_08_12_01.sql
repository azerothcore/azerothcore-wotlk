-- DB update 2026_08_12_00 -> 2026_08_12_01
-- Savage Combat (all ranks)
UPDATE `spell_proc` SET `SpellTypeMask` = `SpellTypeMask`|1 WHERE `SpellId` = -51682;
