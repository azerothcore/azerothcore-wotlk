-- Keep Quagmirran's Acid Spray and Underbog Colossus' Acid Geyser aimed at their channel targets.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (38153, 38971) AND `ScriptName` = 'spell_gen_acid_geyser';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38153, 'spell_gen_acid_geyser'),
(38971, 'spell_gen_acid_geyser');
