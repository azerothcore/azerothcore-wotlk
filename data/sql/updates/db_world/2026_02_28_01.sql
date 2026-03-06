-- DB update 2026_02_28_00 -> 2026_02_28_01
-- Add CheckCast script for Kill Command to prevent casting without a pet
DELETE FROM `spell_script_names` WHERE `spell_id` = 34026 AND `ScriptName` = 'spell_hun_kill_command';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (34026, 'spell_hun_kill_command');
