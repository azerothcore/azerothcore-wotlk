-- DB update 2026_01_10_00 -> 2026_01_12_00
-- bb
DELETE FROM `spell_script_names` WHERE `spell_id` = -49182;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-49182, 'spell_dk_blade_barrier');
