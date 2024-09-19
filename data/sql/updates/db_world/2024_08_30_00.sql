-- DB update 2024_08_29_01 -> 2024_08_30_00
DELETE FROM `spell_script_names` WHERE `spell_id` = 41455;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (41455, 'spell_illidari_council_circle_of_healing');
