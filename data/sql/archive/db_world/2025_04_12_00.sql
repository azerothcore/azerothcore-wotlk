-- DB update 2025_04_11_01 -> 2025_04_12_00
--
UPDATE `creature_template` SET
`ScriptName` = 'npc_sunblade_arch_mage',
`AIName` = ''
WHERE `entry` = 25367;

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 25367 AND `Index` IN (0, 1, 2);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(25367, 0, 46553, 0), -- Arcane Explosion
(25367, 1, 28401, 0), -- Blink
(25367, 2, 46555, 0); -- Frost Nova
