--
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 53000;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`)
VALUES
(1127, 4, 'Toughness - Only Highest Rank');

DELETE FROM `spell_group` WHERE `id` = 53000;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1127, 53120),
(1127, 53121),
(1127, 53122),
(1127, 53123),
(1127, 53124),
(1127, 53040);
