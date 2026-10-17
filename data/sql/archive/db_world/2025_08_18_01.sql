-- DB update 2025_08_18_00 -> 2025_08_18_01
DELETE FROM `spell_script_names` WHERE `spell_id` = 45848;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45848, 'spell_kiljaeden_shield_of_the_blue');
