-- DB update 2026_02_19_01 -> 2026_02_19_02
-- Elemental Focus (16164): change SpellPhaseMask from CAST (0x1) to HIT (0x2)
UPDATE `spell_proc` SET `SpellPhaseMask` = 2 WHERE `SpellId` = 16164;
