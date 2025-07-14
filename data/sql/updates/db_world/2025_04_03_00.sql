-- DB update 2025_04_02_04 -> 2025_04_03_00
--
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (7386, 7405, 8380);
