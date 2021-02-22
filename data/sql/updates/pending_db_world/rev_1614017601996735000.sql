INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614017601996735000');
DELETE FROM `spell_group` WHERE (`id` = 1500);
INSERT INTO `spell_group` (`Id`, `spell_id`) VALUES
(1500, 12880),
(1500, 57518);
DELETE FROM `spell_group_stack_rules` WHERE (`group_id` = 1500);
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1500, 1);
