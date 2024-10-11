-- DB update 2023_07_11_00 -> 2023_07_11_01
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 30658 AND `spell_effect` = 30571;
DELETE FROM `spell_script_names` WHERE `ScriptName` = ('spell_magtheridon_quake');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30658, 'spell_magtheridon_quake');
