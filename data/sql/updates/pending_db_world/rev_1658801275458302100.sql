--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_moam_mana_drain_filter';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25676, 'spell_moam_mana_drain_filter');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_moam_summon_mana_fiends';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25684, 'spell_moam_summon_mana_fiends');
