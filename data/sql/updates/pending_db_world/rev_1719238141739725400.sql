-- Raise Dead
DELETE FROM `spell_cooldown_overrides` WHERE `Id`=34019;
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES
(34019, 60000, 60000, 0, 0, 'Bleeding Hollow Necrolyte - Raise Dead');
