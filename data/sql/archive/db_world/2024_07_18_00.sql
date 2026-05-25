-- DB update 2024_07_17_06 -> 2024_07_18_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_ioc_bomb_blast_criteria' AND `spell_id` IN (67813,67814);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67813, 'spell_ioc_bomb_blast_criteria'),
(67814, 'spell_ioc_bomb_blast_criteria');
