-- DB update 2023_06_26_01 -> 2023_06_27_00
-- 31994 - Shoulder Charge
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 31994;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (31994, 16384);
