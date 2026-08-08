-- Crusher Tentacle: bind the sniffed Diminsh Power proc aura (64148)
DELETE FROM `spell_script_names` WHERE `spell_id` = 64148;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64148, 'spell_yogg_saron_diminish_power_aura');
