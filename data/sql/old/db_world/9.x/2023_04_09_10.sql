-- DB update 2023_04_09_09 -> 2023_04_09_10
-- Risen Ally(30230)
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 30230;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30230, 0, 62225, 12340),
(30230, 1, 47480, 12340),
(30230, 2, 47481, 12340),
(30230, 3, 47482, 12340),
(30230, 4, 47484, 12340),
(30230, 5, 47496, 12340);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_pet_dk_risen_ally' WHERE `entry` = 30230;

-- Thrash
DELETE FROM `spell_script_names` WHERE `spell_id`=47480 AND `ScriptName`='spell_dk_ghoul_thrash';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(47480, 'spell_dk_ghoul_thrash');
