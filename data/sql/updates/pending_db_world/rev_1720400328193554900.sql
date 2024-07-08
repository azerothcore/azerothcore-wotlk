--
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 20042);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(20042, 1, 37112, 55261),
(20042, 2, 37118, 55261),
(20042, 3, 37120, 55261);

DELETE FROM `spell_cooldown_overrides` WHERE `Id` = 37118;
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES
(37118, 8000, 8000, 0, 0, 'Tempest-Smith - Shell Shock');
