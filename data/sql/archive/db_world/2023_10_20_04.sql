-- DB update 2023_10_20_03 -> 2023_10_20_04
-- Bloodlust/Heroism - Karazhan chest event
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (37472,37471);
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`) VALUES
(37472, 15000, 15000, 0, 0),
(37471, 15000, 15000, 0, 0);
