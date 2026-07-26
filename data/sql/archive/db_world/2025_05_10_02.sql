-- DB update 2025_05_10_01 -> 2025_05_10_02
DELETE FROM `spell_script_names` WHERE `spell_id` = -1022;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-1022, 'spell_pal_hand_of_protection');
