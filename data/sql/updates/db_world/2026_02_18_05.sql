-- DB update 2026_02_18_04 -> 2026_02_18_05
-- Hunter T9 4P Bonus - spell script registration
DELETE FROM `spell_script_names` WHERE `spell_id` = 67151;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67151, 'spell_hun_t9_4p_bonus');
