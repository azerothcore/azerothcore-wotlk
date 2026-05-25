-- DB update 2026_02_19_02 -> 2026_02_19_03
-- Enable charge tracking for Combustion (11129)
-- Charges were 0 (disabled), should be 3 to match DBC ProcCharges
-- Combustion should be removed after 3 critical strikes with Fire spells
UPDATE `spell_proc` SET `Charges` = 3 WHERE `SpellId` = 11129;
