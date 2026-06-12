-- DB update 2026_06_11_02 -> 2026_06_12_00
-- DB update 2026_06_11_02 -> 2026_06_11_03
-- Spell (ID: 30213) was added to spell_cone in 2026_06_11_02 but does not have
-- a cone implicit target, causing a server warning on startup.
DELETE FROM `spell_cone` WHERE `ID` = 30213;
