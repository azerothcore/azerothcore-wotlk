-- DB update 2023_02_12_12 -> 2023_02_12_13
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_zereketh_seed_of_corruption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(36123, 'spell_zereketh_seed_of_corruption'),
(39367, 'spell_zereketh_seed_of_corruption');
