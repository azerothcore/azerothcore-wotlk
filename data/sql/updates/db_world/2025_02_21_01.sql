-- DB update 2025_02_21_00 -> 2025_02_21_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_eredar_twins_handle_dark_touched_periodic', 'spell_eredar_twins_handle_flame_touched_periodic', 'spell_eredar_twins_handle_flame_touched_flame_sear');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45342, 'spell_eredar_twins_handle_flame_touched_periodic'),
(45271, 'spell_eredar_twins_handle_dark_touched_periodic'),
(46771, 'spell_eredar_twins_handle_flame_touched_flame_sear');
