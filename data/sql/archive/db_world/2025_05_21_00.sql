-- DB update 2025_05_20_00 -> 2025_05_21_00
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=45770;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (45770, 4194304);
