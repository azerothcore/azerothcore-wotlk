-- DB update 2026_02_25_08 -> 2026_02_25_09
-- Focused Attacks should not proc from offhand attacks (including Fan of Knives offhand)
DELETE FROM `spell_script_names` WHERE `spell_id` = -51634 AND `ScriptName` = 'spell_gen_no_offhand_proc';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-51634, 'spell_gen_no_offhand_proc');
