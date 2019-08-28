INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567002995154862031');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (56698, 59102, 56702, 59103);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(56698, 'spell_gen_default_count_pct_from_max_hp'),
(59102, 'spell_gen_default_count_pct_from_max_hp'),
(56702, 'spell_shadow_sickle_periodic'),
(59103, 'spell_shadow_sickle_periodic');
