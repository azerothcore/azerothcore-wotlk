--
UPDATE `spell_script_names` SET `ScriptName` = 'spell_gen_summon_target_floor' WHERE `ScriptName` = 'spell_muru_blackhole';
DELETE FROM `spell_script_names` WHERE `spell_id` = 45978;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45978, 'spell_gen_summon_target_floor');
