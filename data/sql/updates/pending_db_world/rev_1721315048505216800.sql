--
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 23109);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(23109, 0, 40325, 0),
(23109, 2, 40157, 0),
(23109, 3, 40175, 0),
(23109, 4, 40314, 0),
(23109, 6, 40322, 0);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_vengeful_spirit' WHERE (`entry` = 23109);

DELETE FROM `spell_script_names` WHERE `spell_id` = 41999 AND `ScriptName` = 'spell_teron_gorefiend_shadow_of_death_remove';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(41999, 'spell_teron_gorefiend_shadow_of_death_remove');
