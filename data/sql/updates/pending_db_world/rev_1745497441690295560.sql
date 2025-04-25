-- blue dragon 25% haste aura
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45856 AND `spell_effect` = 49725;
INSERT INTO `spell_linked_spell`
(`spell_trigger`, `spell_effect`, `type`, `comment`)
VALUES(45856, 49725, 1, 'Power of the Blue Flight - Breath: Haste');

DELETE FROM `spell_script_names` WHERE `spell_id` = 45856;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45856, 'spell_kiljaeden_breath_haste');
