-- DB update 2025_04_30_02 -> 2025_04_30_03
--
DELETE FROM `spell_group` WHERE `id` = 1024;
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1024;
DELETE FROM `spell_group` WHERE `id` = 1019 AND `spell_id` IN (1243,8099,21562,23947,23948,46302,72590);
INSERT INTO `spell_group` VALUES (1019, 1243, 0),
(1019, 8099, 0),
(1019, 21562, 0),
(1019, 23947, 0),
(1019, 23948, 0),
(1019, 46302, 0),
(1019, 72590, 0);
