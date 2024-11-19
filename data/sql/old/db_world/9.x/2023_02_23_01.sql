-- DB update 2023_02_23_00 -> 2023_02_23_01
--
DROP TABLE IF EXISTS `spell_cooldown_overrides`;
CREATE TABLE `spell_cooldown_overrides` (
  `Id` INT UNSIGNED NOT NULL,
  `RecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',
  `CategoryRecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',
  `StartRecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',
  `StartRecoveryCategory` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
);
