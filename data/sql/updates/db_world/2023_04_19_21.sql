-- DB update 2023_04_19_20 -> 2023_04_19_21
-- Fel Reaver Sentinel
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (38055,38006,38052,37920);
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`) VALUES 
(38055, 10000, 10000, 0, 0),
(38006, 10000, 10000, 0, 0),
(38052, 15000, 15000, 0, 0),
(37920, 30000, 30000, 0, 0);
