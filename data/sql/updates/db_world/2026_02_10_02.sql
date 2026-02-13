-- DB update 2026_02_10_01 -> 2026_02_10_02
--
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1114;
INSERT INTO `spell_group_stack_rules` (`group_id`,`stack_rule`, `description`) VALUES (1114, 1, 'Love is in the Air Flasks');
