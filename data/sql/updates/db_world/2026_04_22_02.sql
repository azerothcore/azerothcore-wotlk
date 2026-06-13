-- DB update 2026_04_22_01 -> 2026_04_22_02
--
-- Add ICD to Vesperon's Twilight Torment during Vesperon's fight and Sartharion Hardmode
DELETE FROM `spell_proc` WHERE `SpellId` IN (58835, 57935);
INSERT INTO `spell_proc` (`SpellId`, `SpellPhaseMask`, `Cooldown`) VALUES
(58835, 2, 2000),
(57935, 2, 2000);
