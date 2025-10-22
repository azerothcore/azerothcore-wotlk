-- DB update 2025_09_28_00 -> 2025_09_28_01
--
DELETE FROM `spell_cooldown_overrides` WHERE `Id` IN (56570, 56585);
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES
(56570, 200, 200, 0, 0, 'Jotunheim Rapid-Fire Harpoon: Rapid-Fire Harpoon'),
(56585, 30000, 30000, 0, 0, 'Jotunheim Rapid-Fire Harpoon: Energy Reserve');
