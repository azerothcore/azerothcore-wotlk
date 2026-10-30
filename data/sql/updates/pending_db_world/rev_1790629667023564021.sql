--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (46585, 52150) AND `ScriptName` = 'spell_dk_raise_dead_summon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46585, 'spell_dk_raise_dead_summon'),
(52150, 'spell_dk_raise_dead_summon');
