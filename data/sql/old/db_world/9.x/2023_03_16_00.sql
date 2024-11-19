-- DB update 2023_03_15_10 -> 2023_03_16_00
-- Mr Pinchy's Blessing (1300 health)
DELETE FROM `spell_group` WHERE `id`=1 AND `spell_id`=33053;
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES (1, 33053, 3);
