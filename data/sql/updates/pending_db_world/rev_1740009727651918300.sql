--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_eredar_twins_handle_dark_touched_periodic', 'spell_eredar_twins_handle_flame_touched_periodic');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45432, 'spell_eredar_twins_handle_flame_touched_periodic'),
(45271, 'spell_eredar_twins_handle_dark_touched_periodic'),
(46771, 'spell_eredar_twins_handle_flame_touched_flame_sear');
