-- DB update 2024_07_29_01 -> 2024_07_30_00
-- Wing Buffet
DELETE FROM `spell_custom_attr` WHERE `spell_id`=37319;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (37319, 4);
