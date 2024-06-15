-- DB update 2022_08_01_17 -> 2022_08_01_18
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_crystal_weakness';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25177, 'spell_crystal_weakness'),
(25178, 'spell_crystal_weakness'),
(25180, 'spell_crystal_weakness'),
(25181, 'spell_crystal_weakness'),
(25183, 'spell_crystal_weakness');
