-- DB update 2022_07_26_02 -> 2022_07_26_03
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 5255;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(5255, 0x00008000);
