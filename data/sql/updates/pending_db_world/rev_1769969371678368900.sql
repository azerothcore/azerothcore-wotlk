--
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 53000;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`)
VALUES
(53000, 4, 'Toughness - Only Highest Rank');

DELETE FROM `spell_group` WHERE `id` = 53000;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(53000, 53120),
(53000, 53121),
(53000, 53122),
(53000, 53123),
(53000, 53124),
(53000, 53040);
