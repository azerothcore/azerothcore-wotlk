-- DB update 2024_06_18_04 -> 2024_06_18_05
DELETE FROM `spell_script_names` WHERE `spell_id` IN (42463, 53739);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES -- Same script name, don't wanna duplicate the spell script
(42463, 'spell_pal_seal_of_vengeance'),
(53739, 'spell_pal_seal_of_vengeance');
