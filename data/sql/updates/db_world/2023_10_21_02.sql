-- DB update 2023_10_21_01 -> 2023_10_21_02
-- Shadow Mend/Healing - Karazhan chest event
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (37456,37455);
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`) VALUES
(37456, 20000, 20000, 0, 0),
(37455, 20000, 20000, 0, 0);
