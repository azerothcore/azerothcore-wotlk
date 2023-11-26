-- DB update 2023_11_26_13 -> 2023_11_26_14
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 39331;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(39331, 33554432);
