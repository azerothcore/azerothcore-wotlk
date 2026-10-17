-- DB update 2025_04_11_00 -> 2025_04_11_01
--
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 25824;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES(25824, 3, 46082, 0);

DELETE FROM `spell_cooldown_overrides` WHERE `Id` = 46082;
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES(46082, 5000, 5000, 0, 0, 'Void Spawn - Shadow Bolt Volley');
