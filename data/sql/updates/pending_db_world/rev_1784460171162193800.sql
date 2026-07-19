-- Attach Sanity (63050) stack-init script
DELETE FROM `spell_script_names` WHERE `spell_id` = 63050 AND `ScriptName` = 'spell_yogg_saron_sanity';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63050, 'spell_yogg_saron_sanity');
