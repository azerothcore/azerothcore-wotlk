-- DB update 2026_06_16_05 -> 2026_06_16_06
-- Dust Cloud (54404) - remove on the affected unit's first missed melee swing
DELETE FROM `spell_proc` WHERE `SpellId` = 54404;
INSERT INTO `spell_proc` (`SpellId`, `ProcFlags`, `HitMask`, `Chance`, `Charges`)
    VALUES (54404, 0x00000004, 0x00000004, 100, 1);
