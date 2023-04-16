--
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 18708;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Rooted`) VALUES
(18708, 1, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (33666, 38795);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(33666, 'spell_gen_80pct_count_pct_from_max_hp_murmur'),
(38795, 'spell_gen_80pct_count_pct_from_max_hp_murmur');
