-- DB update 2024_08_26_00 -> 2024_08_26_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 41360;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(41360, 'spell_black_temple_l5_arcane_charge');
