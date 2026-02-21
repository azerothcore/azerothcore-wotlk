-- DB update 2024_04_14_01 -> 2024_04_14_02
--
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 17899);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(17899, 0, 2, 54205),
(17899, 1, 31626, 54205);

DELETE FROM `spell_cooldown_overrides` WHERE `Id` = 31626;
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `Comment`) VALUES
(31626, 5000, 5000, 'Shadowy Necromancer - Unholy Frenzy');
