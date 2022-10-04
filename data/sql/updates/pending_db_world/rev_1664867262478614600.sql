--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (58428, 31666);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(58428, 'spell_rog_overkill'),
(31666, 'spell_rog_master_of_subtlety');
