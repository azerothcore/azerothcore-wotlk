--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (66334, 67905, 67906, 67907) AND `ScriptName` IN ('spell_toc25_mistress_kiss_aura', 'spell_mistress_kiss_aura');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66334, 'spell_mistress_kiss_aura'),
(67905, 'spell_mistress_kiss_aura'),
(67906, 'spell_mistress_kiss_aura'),
(67907, 'spell_mistress_kiss_aura');
