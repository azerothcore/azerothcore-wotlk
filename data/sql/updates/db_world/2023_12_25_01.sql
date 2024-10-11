-- DB update 2023_12_25_00 -> 2023_12_25_01
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 37546;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(37546, 2147483648);

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |131072 WHERE `entry` = 21215;
