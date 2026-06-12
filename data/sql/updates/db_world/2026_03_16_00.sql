-- DB update 2026_03_15_04 -> 2026_03_16_00
-- Fix Demonic Pact ICD: should be 20 seconds in 3.3.5, not 5 seconds
-- Also ensure both ranks (53646, 54909) have consistent cooldown
UPDATE `spell_proc` SET `Cooldown` = 20000 WHERE `SpellId` IN (53646, 54909);
