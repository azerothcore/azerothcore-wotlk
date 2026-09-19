--
-- Keeps the Raging Spirit summon on the Arthas Platform.
DELETE FROM `spell_script_names` WHERE `spell_id` = 69201 AND `ScriptName` = 'spell_the_lich_king_summon_raging_spirit';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69201, 'spell_the_lich_king_summon_raging_spirit');
