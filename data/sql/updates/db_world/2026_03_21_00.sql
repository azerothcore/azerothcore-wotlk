-- DB update 2026_03_20_01 -> 2026_03_21_00
-- Spirit Burn (54647) - Add 10s internal cooldown
DELETE FROM `spell_proc` WHERE `SpellId` = 54647;
INSERT INTO `spell_proc` (`SpellId`, `Cooldown`) VALUES (54647, 8000);
