-- DB update 2026_02_25_13 -> 2026_02_25_14
--
DELETE FROM `spell_group` WHERE `id` = 1088 AND `spell_id` IN (-1066, -1067);
INSERT INTO `spell_group` (`id`,`spell_id`) VALUES (1088, -1066), (1088, -1067);
