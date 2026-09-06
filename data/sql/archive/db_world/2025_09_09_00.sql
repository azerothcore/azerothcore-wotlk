-- DB update 2025_09_07_00 -> 2025_09_09_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=45612;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (45612, 'spell_necropolis_beam');
